Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D34EC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685EC20675
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=taz.007@zoho.com header.b="bGKSOqbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBWNSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 08:18:54 -0500
Received: from sender4-pp-o97.zoho.com ([136.143.188.97]:25767 "EHLO
        sender4-pp-o97.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWNSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 08:18:53 -0500
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 08:18:53 EST
ARC-Seal: i=1; a=rsa-sha256; t=1582463030; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QXYz5ZLqwfdrNcaAtFIqgwmXpH0LNQCFMideA43IRSlCYoLc0OMWPgRvKO1zExMddC3ryWrIxwMdcrrTMkMkfj2YFADUE0VQOE75lybPVKFDmIyrhFJ91Rz160ulqHG+LH4l9awAcvNhcs1zuMNsEUEXgbRaV7OmUluXDHWYIr8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1582463030; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=3lx6dYpOAuBPP+/IJMKqzEmGYzk0NdW5qFQFIvEbp14=; 
        b=Kqhs5ntZ0k9EGtm9PeGu5XJFTh1w8/DTAZvMGEtBLhdzAgXyLTp1i6Sslc9PeDoA3uUAqBVA0z0n0yfFvRWAMdIZzrc3NqN/ODgUBR4bgtc2WvjqebDkgV2trXAyLWcWzwTMwO4nDAYFFMjp7F3MhbkfGC3q77XgmYa5CO2L9S4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=taz.007@zoho.com;
        dmarc=pass header.from=<taz.007@zoho.com> header.from=<taz.007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:subject:to:message-id:date:user-agent:mime-version:content-type; 
  b=N6GSCerbyOLzk9c0PBIV4xDNQhMA6oAKzvK9MILGNDaTigVFReKZnMh7hu9wP70fXkF9SUCL36JL
    bEM8EVvh//f8zhMg9aW6/ttOpl1XYkveCIgSwX1/sGp2DR9Gjwwi  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1582463030;
        s=zm2020; d=zoho.com; i=taz.007@zoho.com;
        h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=3lx6dYpOAuBPP+/IJMKqzEmGYzk0NdW5qFQFIvEbp14=;
        b=bGKSOqbdkutdlI+HvMNDTj8Vab+UaWA8cPc1h6LwJPE9mN70DU6gPTAYuVSrTXEM
        sk35LXdbl6RT2xkPJL7GYtE0qXErwxu5QPmZ8WqfqNDuNIbzK8SGNMgit0gWFw/TPw7
        HJfrF9N4NZCUnQdgGBIG2N3TS5HhSN29XWbnaBX8=
Received: from [192.168.1.5] (77.109.97.112.adsl.dyn.edpnet.net [77.109.97.112]) by mx.zohomail.com
        with SMTPS id 1582463028376772.0239410694745; Sun, 23 Feb 2020 05:03:48 -0800 (PST)
From:   "taz.007" <taz.007@zoho.com>
Subject: fuse freeze and usb devices
To:     linux-kernel@vger.kernel.org
Message-ID: <0408cef1-683f-ec03-cdef-894f1e48b869@zoho.com>
Date:   Sun, 23 Feb 2020 14:03:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel experts,


I'm experiencing some fuse user space daemon freeze.

I've created a bugzilla entry so I won't repeat all the details, so see 
here:

https://bugzilla.kernel.org/show_bug.cgi?id=206643

TLDR:

mergerfs is stuck inside pread64(). system is idle, manually accessing 
one of the drives via hdparm/ls (or sync) unblocks the syscall and 
mergerfs resumes.

I have no idea which subsystem is responsible for this behaviour, as the 
scenario is a bit complex.

Thanks for your help.


P.S. Add me in CC as I'm not subscribed to the ML.


