Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC92C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F70206D5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="J9XQ5FS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCEOA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:00:57 -0500
Received: from mout.web.de ([217.72.192.78]:57489 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgCEOA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583416817;
        bh=s1ZuVeCV8QBIqv8S9BIHunoGnnHyV6lYMcex5ZofI2o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=J9XQ5FS7pbRGQmQOIfafJunAT1yTo+2HZzJFR9nOyxahatzdzvJqWMrE76C2r1o2F
         L4MyLHcSzXoDFtOsW0RVkePhdMjXBhCyxOzEYP7CRL6nb4RaJUqXsobzVxJtQIl/BZ
         z3+zkQa31nJivjp9+vPnl+p44gwfCzzQ2uOdvf4M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZUWH-1ivLu01NKX-00LH51; Thu, 05
 Mar 2020 15:00:17 +0100
Subject: Re: [PATCH v5.1] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <158341540688.4236.11231142256496896074.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f3c51b0a-2a55-6523-96e2-4f9ef0635d9f@web.de>
Date:   Thu, 5 Mar 2020 15:00:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158341540688.4236.11231142256496896074.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e2Mc+DM7+FRKfnao3iZnFkPrF/OFxb6Y51pf6DE6VujmnjcZPCl
 jhe2zrw36zbOwkFANk+0EwKiuk62jSQ0iMd3J+LWubKTlXbIIPheIYsm3L7imeNgEk/3Bhf
 eFkKtXH1LfFX0zk7tYaOhHIXwsB46JdAF8NBy32yJc+vtUbNrtNvF6l4SddAZHeAcoNeBCt
 r7khrp5dlUlNtlEkL/26Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hv0bkSPWqGQ=:fgOgifZh7oZm09fj2N+HIZ
 dl4ZKLj93FppYEb+fMfEl5Aole4Z76exffmc+V+hW3A6a6wexLLc46E2eIY+OI4puR+V8z8Up
 91Hhc0R1Wt1WPoDBgoVZgPPOFf773KuufnU5TM/vfEbiMd2FoMv4bAmvYK6QljuOLMen88LEn
 utWvINEvWAziK5MvF+ndKbZpAfRxE7U7T74akoU6aur6SMxYwPdk+325q74wldZGyo09IFlK1
 pjT/4cyHIxsVab5rY/X3nE+snH3KyWoSn0Rm2EMslGDFglQr37+IxHJNpUUjl0WTt2j4Pthqu
 onM9fA8RIc7Fgzc4Rt5U262+1YMUdze/G8oh/IwG4CkxdiqgIoslR5phml1ELLRbMA9aEe1JQ
 qj2WYGVhvFqpqZd5hofNB+1BHYk2el0h4eITZ4pk++Qd52YtIEqQMpt1cUYRDLTh4V5suAGUh
 bHG1VJ8cPVJVhv/ZQ37mK2986s2DVCwbSrenMfSa7qmAGptyWDCEnd1uydJeAwnViZDdmLIt+
 64lJQT+vtshoEQGg12V5p3wJQ1cGNgDwNfriarEev3PCB6EPiNLETsfbsI3xdV0xZQoySora+
 3541XkuDhj9lOe6b0TxfG8NvZsWi+ee1DPl2XCGBZzfujwOgwey1YGbXefMa62Ezydtvmfklj
 SbG8vQCdq9WkM5zxe+KtI33IlS3EX8Q6jb7XXaGzWlYML5LPwJbGHnFI3lp7qbY0glI+IEKOQ
 s9ZTQF9C2w+OV6TdDKKQwo7Qs1h1zMmtnWTYjF6HcDfqGwt1F9/KK75QWyQlwWgfLgfG3ZV75
 CuQOb+aQHsRfSBgeuOr3Uo79A/zZDOrYFhHb6n9bWLeB50JghevzWSpEb6TYbCj8ChBPQKoFg
 x5A/AXifv1pAyScxZPBcXeuo+QaZOyckE/gDAjnzpZugMb3s4+fypODxsNy6afNjvrfQEIiZK
 GXTZO4uwMJPpkulpo5FIfDT14vRtzoU9esQ/WmvdS4JA12e4IZ/1giBJJqVJgulzKeu2d1p8m
 iZrLPyIAYew/v7Ph3MVCTgMLKRfPL3KSnPqOYyx/q4dgjmvqnvL0W4NK5tyOBljGGkf7CSgud
 GieTE2ZJBDx0hPaAOB+BkHSHAawW7lf/oJBuRPLS9BF/sHX7t82AHpIeN96bAvybf8kXOHIqw
 lvB0CytCc4Hb44bALH4NrpO3/D8UNofUOrjheUMFm8fKiFgOHPFq97WMBIHsUOM8VlnnPiL4U
 U/Nj9bN7urmzqdyLs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes in v5.1:
>  - Fix some mistakes (Thanks Randy!)

Do you need any more reminders for remaining update candidates?


=E2=80=A6
> +++ b/Documentation/admin-guide/bootconfig.rst
=E2=80=A6
> +If you think that kernel/init options become too long to write in boot-=
loader
> +configuration file or you want to comment on each option, the boot
> +configuration may be suitable. =E2=80=A6

Would you like to specify any settings in the boot configuration file
because the provided storage capacity would be too limited by the kernel c=
ommand line?

Regards,
Markus
