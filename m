Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8629EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB8C20828
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="BdpU5DsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbgCDVao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:30:44 -0500
Received: from mout.web.de ([217.72.192.78]:49715 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDVao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583357406;
        bh=mgNZGik5S6lzIQpeNai8Nuk17HKYUdEYdjLqz4skHWo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BdpU5DsU10VGkVp3jA3P8oWtsn9FMcaOgOUWSeykxAkBj5aCrrehqQcC/DjSG8f7w
         YFQ58SYfQzl1P21dIxfnXXOcHk5RxuFWx3cbWHnYgZTYMaPvMwuKKPtVjU0Vqu9RJW
         yMsgQftmuSue/bJdSmd47t3q0/04KTdMFyFSWY9o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.53.147]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2MUi-1jSVNy14ui-00s7cb; Wed, 04
 Mar 2020 22:30:06 +0100
Subject: Re: [v4] Documentation: bootconfig: Update boot configuration
 documentation
To:     Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
 <158322635301.31847.15011454479023637649.stgit@devnote2>
 <ad1e9855-4c64-53bd-7da5-f7cdafe78571@infradead.org>
 <20200304203722.8e8699c2a3e0a979aae091b1@kernel.org>
 <3a3a5f1a-3654-d96d-3b4a-dd649a366c65@web.de>
 <531371ef-354a-b0fa-f69f-c8cf9ecc9919@infradead.org>
 <a9f8980e-4325-52c1-d217-d2fca1add37d@web.de>
 <3118d72b-a33c-e6d7-36a1-204d39d2bdbb@infradead.org>
 <a6680eb7-5a1d-ea58-0eec-14f2b5bcd99a@web.de>
 <20200304142259.7eaa3633@lwn.net>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <be741d2a-5a30-c167-3a79-011652ace17a@web.de>
Date:   Wed, 4 Mar 2020 22:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304142259.7eaa3633@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Pju323mmyfLGNhS8/943QHchhj66429t7z4fZ0iu8DH8XByxfFD
 c3RI4E8WrKGygNzKsNUmW2WhqWcgvQvrzncHuSAS7o2YlAXUF6ow1O9mRBlVxvVYzIMdZ36
 UefY6VYl2xuOHGSHSRVxzjPJDmRla+UBXaOtgcplSmgFTDZ0ZA6xjM32qAA1f3Vq6wpwWYP
 bOjkKRp7xWPMNamVC8zFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SkUDe0ifHKc=:qBVOlAnq8MVYdTqqBUr1ZL
 5daXXV3u6M8UoQmxj63+o7k73R6Ihh3IjVtePgoZ0U2f4EWUPw6Bqnj1xDDQpcSZ4UYAkcwNG
 Gn7TuG9X7//WCCo5C2yhdVljJWHlJDZt27kTMERT6zTfO9WQdTtTlxichNgOBOJvujoEkKR7I
 T2TkYh4L4z8czjIfs+O+wXEb3DC96RqB02sgw0aSwghXyYpHQZ7DSuT7k8INjk68DtiihIpoV
 DGvTrYAW2Z/IJICHsXvoBUwHmmG28EsqYd3cmuGHBd8YB6rnsT+FDi+M1/ssXnCPnubHSJ601
 tHyh9c06YK5z6uVsCyVARFSqkL/iEPqxcWcctWD1K1SiivmvS15LiTZrY1/fD6gWrVEEu6vvh
 mwxEC91R5My0/yyW3WK4TTezVsc3XHDK79IvRoScwOxhoNLybra0IuZ1Hh/akoz5hF7yZjt+a
 /9R14ekmcDzz0pdSVtkomUSqLCGHWRyy3DWi0XY5WHCx+MR4XB2iLtllPZ5DiqDzZkMlUoA4m
 ei6gf7wzRQR/+VK6uztNzO48UVk8x8YRLlVS67+FGPerx9URkJh2u2RaRqsga8QlBnyyatrKx
 hfcHQNLIn1eDxyPR8UDW9ErYbXR3UssG8WGOZ2rTtqfd8rIG2yPLUTsw1RVkn4adQalpwSjgB
 9n16Q97lKm1F03uUkywbs8Yjc8BMyk26X3eLQtm4443C7O1PuPLNDBfzuC4ykoRe2ylAmw6dC
 Pf313e5mgKlFZYbicDTIVFig8KXQjYaQVk1mB5KJ9xElimkRpUGynAxb/EHm4BYfl3roRjmQG
 nbg3+J7sI1prtKEVdxtQo8Co3/n6fCTCLMCVGFNZwEmeQtxe973Mr2RtF/LeqzwEJhjmWrMpS
 bOIrXJ+KTv37wfu+RuNbIyOI5xoDYv6iS75IC7/aq4Q40r3gs8d2l6+8nqsb0Lqb88ZroXyks
 sidRp8KwSc3Oh4ZoyVMQCisu4G2k/LV4O6HwO9XPDd2NuWM0tdYYi5JVlNJ4Px0kibqHHFHN6
 w60L8FYXQJpavlio/Y6fGQC2+X9nAB9RIrQAPZ77BIOTry3gPEbdaPp88I9diVtlikGXsuJth
 +/cCwGHUkYjq4/E/lfC/QycT+xtXd5bca03VaCQynsgxjYnzx1KiMifyKl2upbVbal7tTs+OW
 cgj7fE8Giz9usqMdT75hK1wo5Rdxqs+qalAFbQK4vLWO9UwNzx5L5/ps+TGztJYGYNV3xblCW
 D8WsUrzx6XwwCsgTV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Honestly, Markus, I think that the patch is good enough for now; time to
> merge it and move on to something else.

I pointed a few details out for further considerations.
I am curious if they will get more attention for the desired clarification.

Regards,
Markus
