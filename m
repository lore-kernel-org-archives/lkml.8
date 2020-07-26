Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D16C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0E02065C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="PvfEXW/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgGZH6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:58:14 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:58116 "EHLO
        mail1.hostfission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:58:14 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Jul 2020 03:58:13 EDT
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
        by mail1.hostfission.com (Postfix) with ESMTP id 4EEC04216A;
        Sun, 26 Jul 2020 17:49:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
        s=mail; t=1595749747;
        bh=5pXpIjVViNIuGvy8ExDLKr/tvQKrwNajc64XDb5pATk=;
        h=Date:From:To:Cc:Subject:From;
        b=PvfEXW/t1CKOi6Sqb0tOKQrLBxc5KhN3lBOg4b7PFpzRDwA8/XT57VjuTaAdmPZiG
         0+HVeq0oxb3SKX9qBMcaz+Wkq9tz3kbm0mwXeasiO7gj9+RoNEhKTAqBoW+BoNGyWY
         H/6ZE/OlMRaV1z0WrNINbV0VyUOt/zkBujYgRt9g=
Received: from mail.hostfission.com (www1.hostfission.com [127.0.0.1])
        by www1.hostfission.com (Postfix) with ESMTP id 3480A92426;
        Sun, 26 Jul 2020 17:49:07 +1000 (AEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 26 Jul 2020 17:49:07 +1000
From:   Geoffrey McRae <geoff@hostfission.com>
To:     hdanton@sina.com
Cc:     tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Poor windows VFIO performance, GPU stalls (bisected)
Message-ID: <30452714b2935b530b9c2bbf2d20854a@hostfission.com>
X-Sender: geoff@hostfission.com
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The commit 22540ca3d00d2990a4148a13b92209c3dc5422db causes a Windows KVM 
guest running under QEMU with a VFIO passthrough GPU to randomly stall 
when using the GPU leading to the guest assuming that the driver has 
hung. Reverting this commit resolves the problem.

The host system is configured with the following kernel arguments which 
may be related:
   isolcpus=0-5,24-29,6-11,30-35 rcu_nocbs=0-5,24-29,6-11,30-35

The system is an AMD Threadripper 2970WX on a Gigabyte x399 AORUS Gaming 
7 board.
It has two GPUs each being passed through to two separate KVM guests, 
one is an AMD Radeon 7 in a Linux guest, the other is a GeForce 1080Ti 
in a Windows guest.
The cores used for these two guests are isolated from the host for 
performance reasons.

Any insight as to why this is occurring would be appreciated. If you 
need any more information or would like to test patches please let me 
know.

Kind Regards,
Geoffrey McRae
HostFission

https://hostfission.com
