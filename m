Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE19C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6B820737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XzHLkrsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgFIV1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:27:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:33789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgFIV1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591738019;
        bh=ca+9UfhrakPi5uopEO4vgtlu4sEqsAmsxcYe1pIW40A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=XzHLkrsfN/WBhRPM/yxbBVFt77oQWspkcoq1ulwKqY5rnXhZ+2MIxj5FAVb1Dg4zK
         AXqZj1xpkh0PvVb1TQXXFVhIYUAb/Ipewe17la9QIr8c9Cedm0x0+mjpmZ6KK7yHd7
         bgxe/B3OnoT5MJIFbMI8jBXd0uB1laayyMXFhieo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([188.109.195.90]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1j1hj52d0G-00h5Ya; Tue, 09
 Jun 2020 23:26:59 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87bln7ves7.fsf@gmx.net>
        <20200506215713.qoo4enq32ckcjmz7@linutronix.de>
        <87v9l65d2y.fsf@gmx.net>
        <20200513220428.4nksinis2qs5dtmh@linutronix.de>
        <87mu6aurfn.fsf@gmx.net>
        <20200522164012.ynyvrjompv42jtmx@linutronix.de>
        <87y2owwo2o.fsf@rub.de>
Date:   Tue, 09 Jun 2020 23:26:58 +0200
In-Reply-To: <87y2owwo2o.fsf@rub.de> (Stephen Berman's message of "Tue, 09 Jun
        2020 12:06:23 +0200")
Message-ID: <87img0kk0t.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:PG0FyitAtrP3Gaaoolg0F+qRYdqQfEN4AXFGFPd9/jmBEWq9oj8
 iNhi28M9elq1xKut25eCagc8EwqKBMjMKyaYGxr+FHl1VoCb60XsEzICSn0gk8PSbT+VlL0
 9aAPR9e6/2XspRfJxkEBxPbSPae+DYsPrwx8VNFsvfZBuy5eWJDzrBaXAIyfcE80VPLb0PP
 slnmFzcAkDqsuQ+7DoDVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d6sDCbEC1VI=:N6uW8aTFfrUUcvRc4qcwWJ
 Jr4yXpH+bhybEBCKPgvQUkKnKYZr+iQxZnHVUyOyXz5Bwglsyhw/5OlkQEikjIhSGQhn6K6bF
 4Rv3X8HNoHAw66gwkGqqv/FKDVhvWHCJGNaWK4LvJaMbS3/Mdyt70BneHUQS+/x3ng2AIGK5g
 ByUdLeya9+UAytbnw1Pmsz56NuorJGIzs2UC2HU3k94AWDsm+jatUqxm7OEpxyldT7YzReUSz
 zSZaroQ/rpLc79Zsme5cTyv1Q4UH1urH2n2B8/tx96i5mZOt8FkSv28xD1hTZOLFAuVYsF63N
 vKw3MMkqLmjDPuTQaq5By6H5dVnjg9Cn+sbFk4J86Z3YXPOIeRy+6wx9vKhiPjnFsoihz8BNb
 t1SOarCQJGz2L2FgJNpOadBw7ox/3dsXP9K7zom5QmfeDNHPJNU2uwKJ9nkW09IcFjpYcgDqq
 +LOyHSeDd3dvXyzd7g9WSIC5EOwSzs9a9bEprWeUJXNTMOwctz2FpK4AJr0sq3fo16/DK50GM
 tmCk0o1GcXppO1Eq0e+fu5wtl0gesfyp24LbTEz1KZZYeoVRWQpAoEAoydXjghCXP4yDk/CLQ
 UhOibCbbl3v8Jwgn7KUpNTaQAv6tuABn39dSd2eegGY86KANFUp910Ar3Uigm9SgI/OCBg525
 oBVYNUsBjgMPj3NPCexMJK7JdAzQ/lOiReK+tvxpTQVJTuJYo33N+FHvgyUHW6EA1dmI8adJf
 sAE8oUN5CZBZ9mH98WNGfhZeG58A0+60/icPLf4ULYEUCZmEXasN/YoXza7LJB/poldDTnIQe
 3ymz7jt8W2oL+racxLsUroif8AjqSaOcZNkL7G/LZ+OXYv9NAU6lnjNPfhh49ssF/JFC/WReI
 kis2T2nXhFV6LglK9tWIyneXnpcYAEFbqZhHdmA4ofO9HDeyHLwPeXWKlh1HPQOPuwS4M9Zic
 Rhu2ilIQRyLXg/ZU2OqZlp/jp77VxPg5KlAQswg6B1jt3hQq3iCvp4t6VN9fnjUzT7xNKBZY6
 kTJdjfqtGR+XcWTth9RM9seJmyR+w7U1VEmK+1mRUYPKLmyXl2CbqMzv6E8AklaCmLRrg4pnx
 JgiUsRKALP+2kzc9jJHK0UCPX2wJvNhWIVKOCLURD70xkEOP0YELaOhSaQEjcw0RcGnr2344L
 P4MVEj3f+2cDKHYOb8u5QnvEIr8AhgJhzgVMASR06/lV6XeTOC/v0dS/XIjK5lQxKD0R2Y98q
 gstofoAct7ULIaV/o
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020 12:06:23 +0200 Stephen Berman <stephen.berman@gmx.net> wrote:

> Do you still want me to check whether removing the iwlwifi driver makes
> a differece?  And with the CDROM still detached, or does that not
> matter?

I'm not actually sure just what you mean by removing the wifi driver,
but I just now tried moving the iwlwifi firmware out of /lib/firmware,
then booted 5.6.4 as before (with "ignore_loglevel initcall_debug" and
with the CDROM still detached), and of course there was now no wireless
interface.  I started X, Emacs, Firefox (of course with no internet),
VLC, used them a bit then closed them all, then called `shutdown -h now'
and the message output was essentially identical to what I posted
previously (but of course without "iwlwifi 0000:02:00.0: shutdown") and
the machine did not power off.  So if this was the test of removing the
wifi driver, then it made no difference.

Steve Berman
