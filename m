Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275EFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BE92075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORIXSWnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgG2Slx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:41:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2Slw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596048111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wnKx9MtANd6DxtgBYTEmqFSG4Uhuf/WkKPgtmoDTCE=;
        b=ORIXSWnCozCzJXZFcNrZQb28rOVIIEJ/THYNhK6fxHpS+eNtGAZnJ3eafNoNaxjDxvDXGZ
        pXPpfGMQ50LN9NfnCYfrSSpGc+j1TBlV62MBztyY5iu7b3kVVcMWHbpC3llIPAXkUYXTZP
        BZF26elbKg8lbUn6AagWbR+FazWQkAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16--8aINfVjOZ64eSH74sWDJg-1; Wed, 29 Jul 2020 14:41:49 -0400
X-MC-Unique: -8aINfVjOZ64eSH74sWDJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 941EA1923761;
        Wed, 29 Jul 2020 18:41:47 +0000 (UTC)
Received: from Liberator.local (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67AAE1C6;
        Wed, 29 Jul 2020 18:41:46 +0000 (UTC)
Subject: Re: Inverted mount options completely broken (iversion,relatime)
To:     Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <0b154b9b-728f-7d57-d4c5-ec25fc9dfdf3@toxicpanda.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <1f56432b-a245-a010-51fd-814a9cf4e2b1@redhat.com>
Date:   Wed, 29 Jul 2020 11:41:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0b154b9b-728f-7d57-d4c5-ec25fc9dfdf3@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 11:32 AM, Josef Bacik wrote:
> Hello,
> 
> Eric reported a problem to me where we were clearing SB_I_VERSION on remount of a btrfs file system.  After digging through I discovered it's because we expect the proper flags that we want to be passed in via the mount() syscall, and because we didn't have "iversion" in our show_options entry the mount binary (form util-linux) wasn't setting MS_I_VERSION for the remount, and thus the VFS was clearing SB_I_VERSION from our s_flags.
> 
> No big deal, I'll fix show_mount.  Except Eric then noticed that mount -o noiversion didn't do anything, we still get iversion set.  That's because btrfs just defaults to having SB_I_VERSION set.  Furthermore -o noiversion doesn't get sent into mount, it's handled by the mount binary itself, and it does this by not having MS_I_VERSION set in the mount flags.

This was beaten^Wdiscussed to death in an earlier thread,
[PATCH] fs: i_version mntopt gets visible through /proc/mounts

https://lore.kernel.org/linux-fsdevel/20200616202123.12656-1-msys.mizuma@gmail.com/

tl;dr: hch doesn't think [no]iversion should be exposed as an option /at all/
so exposing it in /proc/mounts in show_mnt_opts for mount(8)'s benefit was
nacked.

> This happens as well for -o relatime, it's the default and so if you do mount -o norelatime it won't do anything, you still get relatime behavior.

I think that's a different issue.

> The only time this changes is if you do mount -o remount,norelatime.

Hm, not on xfs:

# mount -o loop,norelatime xfsfile  mnt
# grep loop /proc/mounts
/dev/loop0 /tmp/mnt xfs rw,seclabel,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0

# mount -o remount,norelatime mnt
# grep loop /proc/mounts
/dev/loop0 /tmp/mnt xfs rw,seclabel,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0

Here, "norelatime" only makes the mount binary omit the MS_RELATIME flag.
The only way to override relatime behavior is mount -o strictatime, AFAICT.

IOWS "norelatime" and "strictatime" are the same (right?); perhaps
mount -o norelatime should set the MS_STRICTATIME flag.

> So my question is, what do we do here?  I know Christoph has the strong opinion that we just don't expose I_VERSION at all, which frankly I'm ok with.  However more what I'm asking is what do we do with these weird inverted flags that we all just kind of ignore on mount?  The current setup is just broken if we want to allow overriding the defaults at mount time.  Are we ok with it just being broken?  Are we ok with things like mount -o noiversion not working because the file system has decided that I_VERSION (or relatime) is the default, and we're going to ignore what the user asks for unless we're remounting?  Thanks,

Are there other oddities besides iversion and relatime?

-Eric

