Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E63C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D0D20866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Mw6Z1Xn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgCCJvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:51:01 -0500
Received: from mout.web.de ([212.227.15.14]:33223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgCCJvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583229026;
        bh=yuNdUcJC4vezMuGOYzRqHjBO84TmzYni/K4AQ0gHhgQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Mw6Z1Xn027o2a6nzDxJYY6dg0HGqGPDRvP2MIYnuWHMIldAWRGgW7OOYzOm5xZMA6
         bCPlU8y/7RMovE1Nsl82/GBIePxcOhzvcYlaOlMCbeoZq+ANFw40V4IuMhpDL4F14V
         Cph7i34LybSoTY+PZgX2g/4mbqUvzvCsVoqxuqPs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.62.7]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvB2o-1jZ5aV3qHC-010LrW; Tue, 03
 Mar 2020 10:50:26 +0100
Subject: Re: [v4 0/1] Documentation: bootconfig: Documentation updates
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <447a652d-68bb-12d4-d186-8d5d18670b94@web.de>
Date:   Tue, 3 Mar 2020 10:50:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158322634266.31847.8245359938993378502.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:F7fBN9oMA8ILXGeY2chYndNV4jR3va0MvjEn4Hd3DSIz8+i6Guy
 4xERLXaaOqMEjv/heT3UAX/DHqaBvBtBINiJvOi39LbpfKqshKyI8jJYBzdqQDl+NeKHv9m
 PKKe5QpETakXRlMDYgFWKr9uGn6Rp+EnUpcHMj5cwwUEOlfZCS38Tzrfg2v6KWJx95I8qoT
 wCFtVxXpQcyOA6GZH3Tdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GNCtczklcLk=:EUwuEHY8YGo8zzPQi57JsR
 x2Z5pQyQkGvS1ZjK6PONmWFDZfr6xP5mO0mVQQ9JRl7bqZ5oqGWI3lSVO1LALxMceyxiH4xMu
 cLHwv2+oubgIduOntu4chyfnH0SuJTW7ivjt0zy9iFRSgQLtlBGS7dXMkzxCleeRFN/zNs1DJ
 Z99CKPnH6HUw5HqcGS8YVab0JIuojJCf1UedSiNBfiEKZza5bhk66ErQ/RNbrvE60bPrmnzCx
 i/qiydU8SAbv7yS67oRDVm9gF3sYxC4Ce8B/yowuO+zK1iBCDsEt+W+/jcTWZvOc+etmiVdgU
 aK6iimnrOp6d3RuQd075me/fMMv2ifrqL5tHUt4zJsFXEKDhlh692Z4EGEv4/fw23hFc+5L5H
 eOpARUIZs7bTS8YqkCPKy9PO9InsNAvWFKwRifJDIvNCNXpMrHtPWvQSayqP4D7zxSA2fpfbZ
 yUuzgfkJRRwV03DAy35yC70ECmJGRjaRl2thSFgl0miIXpXv40MhYonDe7YGJJGhSDwi2d+Mt
 ogQiV1kRdDdqC3JhAnHBVBVvJggmsREETXzbsZ50NImeyS2+EjIgIpzxsqScURbuYDUANYH4U
 TviT7s3WECgNgtWcYu7DSi3r+4GG3+5sAZ7Cm+PHtZQJHrl5WLibAiJpKes/nCigp8WjQYBpH
 0NkuetWOz7/MfG9ZZ2EVwor17UqhanIGLnKf3tNamEWQ52cA44iTmjM3Zzv1D3VkS5UfAngNM
 nRqiiwlBmg8gToQpJgOoUeULElsMEjOAohm4V6Fp3LVASCG7IRadeGEo5glqhLRkvZLt59bVM
 sIuXdQvnjU6xAl8z7QP45Ha5ZV309zeV0hgaEOswiu3LaBvIVg5w8T1Nqt21gfE8yhQHeaKeS
 uvT8xgZXqSsM+TY+TRUMKCfVRvL9z6j6w8f9KwrBSxjYEzX0dxWixn9XnoIzXyhULsdPo4zVr
 Ya5L/C77C3jP7ME6NiGQJf3zLBdNpoaJc7InboJpTP0u28jqbJ1y5n8jDDNS8XKw4HjCSN9rm
 6WerzRcllWgW2oVmAzjqXVH+KQqjOEOBwZy6EO3SpyF+CO7/PZAvEtsAXobo2oAJA9uhCZY9O
 2ACw8eAeWaNiIJn+oKhkKeIsmYTwM0Y6uABwp/33HzhM6VGONXFWMJGrKSvo9TuGPHs1B+NPH
 jM+pPDnoY1qn2sf+F6cxZ7ffcwS33IjR8t7GoMrILujuqwnbHRxmVTrcGi2uv6vOtubrbEFQK
 C9Gh7Ue2PscHJqf/I
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the 4th version of the documentation update.

How do you think about to take previous review comments better into account?

Regards,
Markus
