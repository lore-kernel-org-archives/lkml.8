Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8E1C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8072E20684
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 20:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgBVUlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 15:41:08 -0500
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:51505 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgBVUlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 15:41:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6D94A4995F1;
        Sat, 22 Feb 2020 20:41:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bead20_98bab56d3062
X-Filterd-Recvd-Size: 3025
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Feb 2020 20:41:05 +0000 (UTC)
Message-ID: <7c30fd26941948fa1aedd1e73bdc2ebb8efec477.camel@perches.com>
Subject: Re: [PATCH v3] proc: faster open/read/close with "permanent" files
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Sat, 22 Feb 2020 12:39:39 -0800
In-Reply-To: <20200222201539.GA22576@avx2>
References: <20200222201539.GA22576@avx2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-22 at 23:15 +0300, Alexey Dobriyan wrote:
> Now that "struct proc_ops" exist we can start putting there stuff which
> could not fly with VFS "struct file_operations"...
> 
> Most of fs/proc/inode.c file is dedicated to make open/read/.../close reliable
> in the event of disappearing /proc entries which usually happens if module is
> getting removed. Files like /proc/cpuinfo which never disappear simply do not
> need such protection.
> 
> Save 2 atomic ops, 1 allocation, 1 free per open/read/close sequence for such
> "permanent" files.
> 
> Enable "permanent" flag for
> 
> 	/proc/cpuinfo
> 	/proc/kmsg
> 	/proc/modules
> 	/proc/slabinfo
> 	/proc/stat
> 	/proc/sysvipc/*
> 	/proc/swaps
> 
> More will come once I figure out foolproof way to prevent out module
> authors from marking their stuff "permanent" for performance reasons
> when it is not.
> 
> This should help with scalability: benchmark is "read /proc/cpuinfo R times
> by N threads scattered over the system".

Is this an actual expected use-case?
Is there some additional unnecessary memory consumption
in the unscaled systems?

And trivia:

>  static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
>  {
[]
> +	if (pde_is_permanent(pde)) {
> +		return pde_lseek(pde, file, offset, whence);
> +	} else if (use_pde(pde)) {
> +		rv = pde_lseek(pde, file, offset, whence);
>  		unuse_pde(pde);
>  	}
>  	return rv;
>  }
[]
>  static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  {
>  	struct proc_dir_entry *pde = PDE(file_inode(file));
>  	ssize_t rv = -EIO;
> -	if (use_pde(pde)) {
> -		typeof_member(struct proc_ops, proc_read) read;
>  
> -		read = pde->proc_ops->proc_read;
> -		if (read)
> -			rv = read(file, buf, count, ppos);
> +	if (pde_is_permanent(pde)) {
> +		return pde_read(pde, file, buf, count, ppos);
> +	} else if (use_pde(pde)) {
> +		rv = pde_read(pde, file, buf, count, ppos);
>  		unuse_pde(pde);

Perhaps all the function call duplication could be minimized
by using code without direct returns like:

	rv = pde_read(pde, file, buf, count, pos);
	if (!pde_is_permanent(pde))
		unuse_pde(pde);

	return rv;


