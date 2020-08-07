Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E93C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0072075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgHGL0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:26:13 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgHGL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:26:06 -0400
Received: from [192.168.1.155] ([95.117.97.82]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N94FT-1kpjmq0UQp-0169WS; Fri, 07 Aug 2020 13:25:59 +0200
Subject: Re: [Q] devicetree overlays
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <24f1687c-043a-a15e-0be4-8392e7b5c96b@metux.net>
Date:   Fri, 7 Aug 2020 13:25:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MdoVwTBHpQAEt7X370CN3OEUwq5XPFtJF55e87EnyotU+j0hGLT
 r88s9rtPBhR57ZR2n5+T+hKlK855Nd2VGTFSf594J90Lhly7yc6RUhYeiaIbihnv5lzIL8I
 VUXMP5+uoQYZTCHHHKo/s3kQk81iSza8bwHiTy4Muu7CgqCbRphSZFFYtkl2ZIJShdvBekJ
 8Hr0iDMMewuYIpI18lJFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TPpcmDmOhXA=:DK9WKNPidd0tc8/Sib4mLF
 P4YzqhzJtiYjVI9d4fjIfzEvpR8HMiP1J4xvip08YPUeubfqmnJ2vtyd+h9JO+p8v3Hw3Wgqy
 t4N/xVuvJA4It8YpxNsgdcTFxJHC4s+I639XhXXqGphNxe8T3x54vEmMOZbaBK+yADVUGzlFT
 cCa6f65A4kAKbcA9zk3Z8PeuHntDuHL7J4S8C7EdRNgUwGIW42sADGnboWdREbvvZayr48mdh
 CSdgNjWcHoXfy4AHIl6JqTWmwCzqpQtqhcA9jDovZHnxIQbz8uCSI/PKLVwvF4L1lAH0ogb7Z
 XSu9u/iyv8nwdTHLa6GYTxdgx4aGBviKEJlulIHBKmyEiQKO/P/6N1RgWNY/JtgKSp0Yu4xJX
 OybEiu3lqQPPSfB5CMfB/HfcvUdaSZr4yortY+a7l+DyZg5ZJLnBTBeBGVANhv5iKB50tYGbR
 erjvsfOYhduDbJ/0FOSTAX77/OOjJ51kx+jcDm4PXymWNjp4fJT4vXV/eOb9n0152GoYV9ZEF
 vZFdD9p2aX/u2aScFeHT2NVpCtN1ZW2TTusLI0MT9p4CsD75tn1JDZhYWCZnepVgH73FPlls9
 4NYNq6K++ok9GB6NUX5Sn4jsGqCfxpuV0YfFDRc+sl87CG63gt1ezLb+6No68DB4o1hL09/pq
 hyiOaRqjQnHj6Afn6yTfzLK/+Ysu6mGlZ1wAxY4/QR+d4GFc6bhaH1upXYY/Fnt59od1V7C3F
 p4mFkpr3jzGAahW1u4HIdUZGRMM1DTCpoxq6chTTyUG46nMSTfn+TurRZgQoHRc1V9HgKjLud
 aRs/4I3uqeaxz7ZnpVmri/GRpNR8OL4lYTYCAZ3DHa1niouBODazEEctfQ4aQESub/ra/I6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.20 16:46, Sven Van Asbroeck wrote:

Hello folks,

> My situation is this: I have hardware which consists of several modules.
> Knowledge about the type and location of these modules is located in an
> on-board eeprom.

I've got a somewhat similar use cases, but not necessarily on DT-native
platforms:

a) composite devices that are probed via PCI or DMI and just instantiate
   a bunch of other (more generic) devices.

   For example the  APUv2/3/4 board driver: it eg. instanciates the
   gpio-amd-fch driver first, and then binds specific gpio lines to
   appropriate functions, eg. reset key (input), LEDs, ...

b) I2C devices behind an USB-based bus adapter.

In both cases it would be nice to have the actual device configuration
written as a DT snippet, which just needs to be loaded.

Let me know, if anybody has an idea how to do that.


--mtx

---
-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
