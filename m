Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA7EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B5E206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aslenv.com header.i=@aslenv.com header.b="bzbKxeqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFRxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:53:03 -0500
Received: from saturna.islandhosting.com ([144.217.72.42]:46008 "EHLO
        saturna.islandhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCFRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:53:02 -0500
X-Greylist: delayed 1382 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2020 12:53:02 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aslenv.com;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
        Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7Vaq7NyhziiQ6abkcm0d9o4/7FGijSW7QW1vVly7flU=; b=bzbKxeqIehnCAehvKuW2FVvDcC
        BIJzibsDpnF8+YAxma0QhGCKna/TQR+NnAn4SqYoVPW8yrIv272ok9cBjPna2oCSDCyvzInodZMJL
        ZsnMV8fmPzXMiFSml84cznVE04mM+S9xT3ZT3SJ3ov5GTzKRlxybs0gaaRGy4xHf1mAsLL+UkZugL
        KJXobmb7iug76FWblxrasKZMuhVdRNM5npFX1Mm7eff22WuYcxoUCuOiQtlUoK3XQ4QYgsN3PLhnS
        R4FxU/4IpoWbX99MICpJmEMdVeWEwds2zSOJa9cNozvNCpPyDqitIr4fVgpUYmcL/7JcadDkNcMGo
        zDnFBFbw==;
Received: from [64.251.74.18] (port=47209 helo=PWW72014)
        by saturna.islandhosting.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.93)
        (envelope-from <pwillis@aslenv.com>)
        id 1jAGnN-00DjFF-K7
        for linux-kernel@vger.kernel.org; Fri, 06 Mar 2020 09:29:57 -0800
From:   "Peter Willis" <pwillis@aslenv.com>
To:     <linux-kernel@vger.kernel.org>
Subject: What kernel version does    'irq_set_irq_type'  become available?  
Date:   Fri, 6 Mar 2020 09:29:57 -0800
Message-ID: <002301d5f3dc$dc029890$9407c9b0$@aslenv.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXz3NrsRI7q+O/2TfeZzUIoTsPs5Q==
Content-Language: en-us
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - saturna.islandhosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - aslenv.com
X-Get-Message-Sender-Via: saturna.islandhosting.com: authenticated_id: pwillis@aslenv.com
X-Authenticated-Sender: saturna.islandhosting.com: pwillis@aslenv.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there a history diagram somewhere that shows where specific features =
appear in the codebase?

Various online documentation for kernel driver development have =
references to functions that, in some cases, are either deprecated or do =
not yet exist in older versions of kernel source.

For example, I have written an interrupt service driver for an embedded =
application running on kernel version 2.6.21.  The original driver is =
level triggered and requires the driver to:=20

a.) Temporarily disable the interrupt
b.) Service the interrupt
c.) Re-enable the interrupt

There was some desire for that driver to move to a more standard rising =
edge trigger.

In that line of thought , the documentation suggests    ' =
irq_set_irq_type'  with flag     'IRQF_TRIGGER_RISING'.

That function was experimental at one point, and doesn't appear to be =
available in the 2.6.21 source.
I did a      'find' -> 'while read' -> 'fgrep'  search to find the =
function declaration in headers but had no luck under 2.6.21 .

-- My specific questions --

Question 1.)   Is  'irq_set_irq_type'  still experimental ?
Question 2.)   At what version of the kernel source does the function =
appear?
Question 3.)  If the function exists for  2.6.21  What headers are =
required to allow effective compilation?


-- Notes and suggestions regarding kernel function documentation --

Note 1.) Perhaps functions should be documented with indications of what =
kernel versions they apply to.
Note 2.) In function documentation, an indication of what headers to =
include supporting each specific function would be nice.

Thank you for your time and comments,

Peter




