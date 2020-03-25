Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1056C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7835120772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FHKHhVNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCYRWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:22:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56831 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgCYRWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:22:30 -0400
Received: from [IPv6:2601:646:8600:3281:c898:2a71:8b3c:1618] ([IPv6:2601:646:8600:3281:c898:2a71:8b3c:1618])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02PHL55v3526219
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 25 Mar 2020 10:21:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02PHL55v3526219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020032201; t=1585156867;
        bh=ucC3weRqhDQdNbcns5oA5TYTC1s6BG+hwqL9v/DS6Wc=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=FHKHhVNUTycvw+HKogfsSM7r3lsQGrMBvBlKUTPWeFmJ7Fb2JkegDImFuFi59sten
         hWWsRUkYPmVZg4h9zjVqNKcMIUkyW0Q1bJc1s79Q0Imcr6d8ePg6A1T6L9PlPEmMrl
         KHFVO9DlKwrAIHT4dEyMZiuCv6ULwOA8wbwQh7NNYlKYYnsm54YmqvvqI2UolgCcG/
         nKD7C4hNq+MCjr+/bpIDL7wI9CvKZj0HWnwvHE3itRtM9JGGIuskDUldSLyDK/U8yv
         uuspBelf55olHtf7Z/9+sjgBhZznIi6wPJOUiO4ydfK7TWUCL0KY2N8hUHh7pB34RG
         asf3GMWi/5p8w==
Date:   Wed, 25 Mar 2020 10:20:57 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP6exYKCgyM-PFPGLds9LcLPjOMOX40ff2261ZpUuUYijRrCxg@mail.gmail.com>
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com> <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com> <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com> <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com> <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com> <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com> <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com> <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com> <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com> <0f31f437-c644-210c-8dc9-22630ab9bd0d@zytor.com> <CAP6exYKCgyM-PFPGLds9LcLPjOMOX40ff2261ZpUuUYijRrCxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     ron minnich <rminnich@gmail.com>
CC:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <D0A5B937-74DC-4469-B24E-4F111DD3D1C2@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 25, 2020 9:19:26 AM PDT, ron minnich <rminnich@gmail=2Ecom> wrote:
>I think it may be fine at this point=2E The only reference to initrd=3D i=
s
>in some of the platform-specific docs and I'm reluctant to change
>those=2E wdyt?
>
>thanks again
>
>On Tue, Mar 24, 2020 at 8:31 PM H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> On 2020-03-23 15:29, ron minnich wrote:
>> > sounds good, I'm inclined to want to mention only initrdmem=3D in
>> > Documentation? or just say initrd is discouraged or deprecated?
>>
>> Deprecated, yes=2E
>>
>>         -hpa
>>

Looks good to me=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
