Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E1CC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A554224654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgAUKBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:01:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:50962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgAUKBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:01:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D01F9AD3A;
        Tue, 21 Jan 2020 10:01:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <C00VV4QDHC2Q.20QYUR6KOPB8G@pride>
Date:   Mon, 20 Jan 2020 21:01:23 +0100
Cc:     "Mark Rutland" <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: bcm2711: Use bcm2711 compatible for sdhci
From:   "Nicolas Saenz Julienne" <nsaenzjulienne@suse.de>
To:     "Stephen Brennan" <stephen@brennan.io>
Message-Id: <C00VWYLKZXHQ.2H1VAQ79Y4KCC@linux-9qgx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon Jan 20, 2020 at 11:59 AM, Stephen Brennan wrote:
> Hi Nicolas,
>
> You're right, this patch doesn't work (it doesn't even touch the correct
> device tree node). My bad.
>
> > Your UHS class 1 card should work out of the box using the current
> > kernel version.
>
> I've been debugging an issue (reproduced on today's linux-next) in which
> my
> UHS class 1 card's partitions don't show up in `/dev`. For example, if I
> do
> `ls /dev | grep mmc`, I get just one result, "mmcblk1". I thought my
> patch
> fixed the issue, but it turns out that the issue is sporadic: on some
> boots, the issue manifests. On others, the partitions appear in /dev as
> normal. When I tested this patch, the issue had sporadically
> disappeared,
> leading me to believe the patch was effective.

Have you been playing with different device-trees? notably with the
Raspberry Pi foundation ones. Your mmc numbers could change, which might
be confusing.

If 100% sure it's failing, i.e. nothing happens for the mmc device after
seeing:

	mmc1: SDHCI controller on fe340000.emmc2 [fe340000.emmc2] using ADMA

I suggest enabling some extra debug options. Build the kernel with
DYNAMIC_DEBUG enabled and add dyndbg=3D"module sdhci +mfp; module mmc_core
+mfp" to your kernel command line. It'll be extremely verbose for the
working case, but we can compare both and try to find something fishy.

Note that I use two UHS class 1 cards myself without issue.

> Sorry for the noise!

On the contrary, the more we are the better :)

Regards,
Nicolas
