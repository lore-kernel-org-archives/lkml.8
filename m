Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39ACC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D565F2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHUTjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:39:12 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:52098 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgHUTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:39:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5763C8384365;
        Fri, 21 Aug 2020 19:39:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rod43_3d0fd782703b
X-Filterd-Recvd-Size: 3830
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 19:39:08 +0000 (UTC)
Message-ID: <1ad67130d11ae089fbc46fd373e1e019e1de06f8.camel@perches.com>
Subject: Re: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
From:   Joe Perches <joe@perches.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Fri, 21 Aug 2020 12:39:06 -0700
In-Reply-To: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
References: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-21 at 16:25 +0000, Konstantin Komarov wrote:
> Initialization of super block for fs/ntfs3
[]
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
[]
> +
> +/**
> + * ntfs_trace() - print preformated ntfs specific messages.
> + */
> +void __ntfs_trace(const struct super_block *sb, const char *level,
> +		  const char *fmt, ...)

This is a printk mechanism.

I suggest renaming this __ntfs_trace function to ntfs_printk
as there is a naming expectation conflict with the tracing
subsystem.

> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +	if (!sb)
> +		printk("%sntfs3: %pV", level, &vaf);
> +	else
> +		printk("%sntfs3: %s: %pV", level, sb->s_id, &vaf);
> +	va_end(args);
> +}

Also it would be rather smaller overall object code to
change the macros and uses to embed the KERN_<LEVEL> into
the format and remove the const char *level argument.

Use printk_get_level to retrieve the level from the format.

see fs/f2fs/super.c for an example.

This could be something like the below with a '\n' addition
to the format string to ensure that messages are properly
terminated and cannot be interleaved by other subsystems
content that might be in another simultaneously running
thread starting with KERN_CONT.

void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
{
	struct va_format vaf;
	va_list args;
	int level;

	va_start(args, fmt);

	level = printk_get_level(fmt);
	vaf.fmt = printk_skip_level(fmt);
	vaf.va = &args;
	if (!sb)
		printk("%c%cntfs3: %pV\n",
		       KERN_SOH_ASCII, level, &vaf);
	else
		printk("%c%cntfs3: %s: %pV\n",
		       KERN_SOH_ASCII, level, sbi->sb->s_id, &vaf);

	va_end(args);
}

> +
> +/* prints info about inode using dentry case if */
> +void __ntfs_inode_trace(struct inode *inode, const char *level, const char *fmt,

ntfs_inode_printk

> +			...)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	ntfs_sb_info *sbi = sb->s_fs_info;
> +	struct dentry *dentry;
> +	const char *name = "?";
> +	char buf[48];
> +	va_list args;
> +	struct va_format vaf;
> +
> +	if (!__ratelimit(&sbi->ratelimit))
> +		return;
> +
> +	dentry = d_find_alias(inode);
> +	if (dentry) {
> +		spin_lock(&dentry->d_lock);
> +		name = (const char *)dentry->d_name.name;
> +	} else {
> +		snprintf(buf, sizeof(buf), "r=%lx", inode->i_ino);
> +		name = buf;
> +	}
> +
> +	va_start(args, fmt);
> +	vaf.fmt = fmt;
> +	vaf.va = &args;
> +	printk("%s%s on %s: %pV", level, name, sb->s_id, &vaf);
> +	va_end(args);
> +
> +	if (dentry) {
> +		spin_unlock(&dentry->d_lock);
> +		dput(dentry);
> +	}
> +}

Remove level and use printk_get_level as above.
Format string should use '\n' termination here too.


