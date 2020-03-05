Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4F9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33F3207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rU4VfklE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgCEU2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:28:13 -0500
Received: from mout.web.de ([212.227.17.11]:34953 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgCEU2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583440002;
        bh=48fPwoOaeJH3DLGqL1GISDijN89G27oNsp3RcwO+wio=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rU4VfklEfu1H51oewVT5HPajd3IQUvAKUGVpdXsY+ZaBqquuU8/nal1wO82mD541l
         bPgiSeSYIXy5sRqAMRV+DdxVgEs4U4jNWm7P+vdK/LOzCaemcqKA46dLUAVJ8ZuyI5
         l0DcnTbArew8/x0eB/0BBtod5gYqnyWPQ5Ey/dMY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8hsl-1jWJYP0LAJ-00wDjo; Thu, 05
 Mar 2020 21:26:42 +0100
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
 <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
 <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
 <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
 <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
 <a6a216ce-8e41-ca35-bd65-25bcacde1d28@infradead.org>
 <ac1c953b-fa5d-818d-5232-19a28f52f556@web.de>
 <20200305142632.1ed2726d@gandalf.local.home>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <536b1932-33a4-020e-de4e-28c338d2737f@web.de>
Date:   Thu, 5 Mar 2020 21:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305142632.1ed2726d@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i3PxAHrpE/4Cwz/2VR5YbzN/VQJJia1GmEh0K3Dr74lhKjJLauB
 OiizIQX5vIBC8WK9jgbmUO5J3joY5SMe0HBFxAhC7fvObpchXFyAxt1GfsP2ExCc7FFllJy
 FVhyYtKHXAjbCGdEYF2IYu9PkJB5wL29zqv02wQnCpQEscr1nZadNMgd1+mQHzY9lDe7hhd
 mASxn8uNtiRPLgc2ad6ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zVU8gHCD088=:BMqZ8A5cSbQrUMbEZvGYNl
 wuxugbVnbfhl5Ij2mYcWu6Vc/Lf1enjDdMfUKSei1mheS3JEQltLxY9fXrFEDd3vUAt8LsfbZ
 lELHgRZ/LTKtohiHY3PJa/cikVVT2WqhNcBfjUekorBx83Z5GSQHl/qbcyJSII0uDepNaA/e4
 ua6sIBql0QCrHtWUyLPD4eDDj4iHrt8RatT4GxWlhPnQ9qbuzE+0aIBNywl7vQEGoICw60zEz
 C27Rk4e9RovcetyoX7Ai1SaB60JsiEFPvG6vAmuxJln6WUtRrV50zgnKMyv3ZbcWZxsBiCMPA
 NZ24ZmBM0+HZqCx4WKjzaGIJkLFq/QPEQK1i5ICnhssrR/XVKOViQqz8NGgTBzXJy8JC7QLag
 EGnRxHI8Ka6p6QAx4xCtXsOlZoW12cscqrf/qFQtqkS1Ps80wOclshS5Bx1NIt4O19+o/mzuC
 i86NLGwEfmGs4Y7z76Gk7PWPhzaBwQFCA4TGxyPpZ6MtibGuCvUOVmRrZo5fj9DGWfcx7ceMC
 4l3QpvF7jdOtmaNSWC6rNXU2eOgKPrg/Y4GLaFOMtqC6ColQDsyYMC74y/XubLnDAk+3b6stq
 2WHUhvBtZt9Mp/LJodM4TD39DxMZqEVx+5+0VFWcuOn2h7xuKCM4SPpYfyVrSVtSbUmvQSq/s
 rZX8hxjJT5bt+EESfP7x9VLFIa9eZUc6gWvAyLK6KewGz7G3uKpWv3xW/bIc+cGY/OmR8gkrp
 MP3whBmfVSSQp4h8DomlF+8VZpCy8GYfwhLi2QuJkELte5QyWFBnm77zCNEwg4JwqS4SI8c5g
 dwChXyNXKIfrLQMgPJT/xA9XbqIYOIW2tNpiKzViVfukKM5bLu2MgvW0f0J08VLrohUsDlZwi
 ArS8MMFUZ5LhH9zD/6SdMCRD+lKhsnp3I7TQqdDp9IsF3g1E0DmUlsNRcnVphO2w3LE09Vv3S
 LruDSsxJcEHShyGZElLj13k8AWiEt43CAmQRTB9rcmxlzu3w9iT6QCJO2sUvwAQjy5d5n4uzO
 fqZ11J+WJFNWlC9d0TMemSlgWQUS25YfRVeL3rbByuutByw2nDPRA4n+F8D7kjiLbo6zCGiav
 7Go8rYsBDTfJX3d3FiBFBhPuADwUfXHi+TsxtA4WA4J4aofjsFu17rVp2pniL2nF1bst2nzLm
 zC11mIDQItVSCD6+JaJnCziw5KN2KY2v1Isf6rRhK6o9JmmQX1JWFgYanvO+uI1VJNkA5KXn5
 EINQsqfCExL6qhVUX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Masami seems to be responsive.
>>
>> The involved contributors show different response delays, don't they?
>
> Of course! Masami is in Japan, and is probably sleeping right now.

I am not so concerned about the global distribution of contributors.


> That's what happens when you work in a global environment.

I am used to this fact for years.

I became more concerned about information which was not directly provided
in patch change logs (according to my software development expectations).

Regards,
Markus
