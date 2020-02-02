Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD74C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 00:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243D220661
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 00:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="AjOB1PUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgBBAIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 19:08:43 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:13678 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgBBAIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 19:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580602118;
        s=strato-dkim-0002; d=xenosoft.de;
        h=In-Reply-To:Date:Message-ID:Subject:From:References:Cc:To:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=M2p6BlJKlzc7zwD9OCcddn1toLSZU/FWLhGgP48heGQ=;
        b=AjOB1PUnBi+TU0fa4pRuQ6tNu1jDWqf8+zz5WetzCE8ADGCi9awwr9JhHGSS3VvuxU
        V1mvMeUiQTdB2b3/jvBPasRVFICVs9cl+hY2FQJJM3qdx/tp3dU3b6hUNp4zKwuHNk7t
        wNRSKytjZSrb1F9vnnFe73z5aesjKRJtdFSMUZuMgMfQqdu/RPkw29L6wCluuf12d3Ca
        HpvpUQ29wSMPrmRRnonOVaX3nkdtuczshYsDddHXNknNbm0iFG49dTMSqNhtGYPOgaJs
        boqpPuS9hCm6DbQUCbkL9zejYOwcLw+/G/ITnam8KATzPDOkmE2fp6RDaMV3um9DB6fq
        IMLQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSLlpvF7aofGh9KUohSyVOsmPy"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:188b:8a2:e727:e5f1]
        by smtp.strato.de (RZmta 46.1.12 AUTH)
        with ESMTPSA id 40bcf3w1208HBpI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 2 Feb 2020 01:08:17 +0100 (CET)
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Darren Stevens <darren@stevens-zone.net>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, linuxppc-dev@ozlabs.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        "contact@a-eon.com" <contact@a-eon.com>
References: <20200126115247.13402-1-mpe@ellerman.id.au>
 <CAPDyKFrbYmV6_nV6psVLq6VRKMXf0PXpemBbj48yjOr3P130BA@mail.gmail.com>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Latest Git kernel: avahi-daemon[2410]: ioctl(): Inappropriate ioctl
 for device
Message-ID: <58a6d45c-0712-18df-1b14-2f04cf12a1cb@xenosoft.de>
Date:   Sun, 2 Feb 2020 01:08:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrbYmV6_nV6psVLq6VRKMXf0PXpemBbj48yjOr3P130BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We regularly compile and test Linux kernels every day during the merge 
window. Since Thuesday we have very high CPU loads because of the avahi 
daemon on our desktop Linux systems (Ubuntu, Debian etc).

Error message: avahi-daemon[2410]: ioctl(): Inappropriate ioctl for device

Could you please test the latest Git kernel?

It is possible to deactivate the avahi daemon with the following lines 
in the file "/etc/avahi/avahi-daemon.conf":

use-ipv4=no
use-ipv6=no

But this is only a temporary solution.

Thanks,
Christian
