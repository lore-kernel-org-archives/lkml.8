Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA16C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECDF5208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qT/3ml4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHLEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:04:11 -0400
Received: from mout.web.de ([212.227.15.14]:44795 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgEHLEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588935793;
        bh=c9S9YQqI67Ut1hb9mGfmb0uXO8OHJpACeLw+sXmMQH4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=qT/3ml4Q28KaqNcMgUPKa6qR7AFbI5sxDtqzEfFr0aBld0oi+qbIqCkzbBynOpSZy
         8rYIKwD55ylYNoYZ4pb15fo2xlb2ArPsOP5GzwSZ+QTyAdfAEw+FyTqhPFByPOTEPU
         fedGLuRHWGxZAuRa9Kj6YiU3WseFWphEy3SXi25A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lv7eE-1j7Kz50Wp8-010Okc; Fri, 08
 May 2020 13:03:13 +0200
Subject: Re: [PATCH v3] tools/bootconfig: fix resource leak in apply_xbc()
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
Date:   Fri, 8 May 2020 13:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FQdNLKBV7s/N7eSryvWj9UO2O2wbostJB794cgIyhdQXN8ptV85
 AWIsuoAbra/H8zZ0ihf8mqN/AqiCNIAK89k5rj7vmexqicbcxHG1EADs8QP5RIUKg68LgHO
 zfeK/lC1ODbh8vzrAF1y7ZuQ8cRROPLkPr7eRDdaW5Gl5gtq0EsH45t3Xp/X99kckatjkzd
 EmC/9YuiRbqxvy5tBcrKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aDhgPo9rUjE=:7gHk1urOAQE4Ij5TVK006n
 /Sei2G+hJ7O7vbkb9b/GanK/ed5etVM5qETJi5QsVuEHglleLrpRyLhezoEDUYOMAAn/pz/9p
 2oc9D3G15/hJ3mPlV3gKcWIqtCvP+BVyfRqjoD7PGdmPkN6CIp99Q44Z5jLe95YUFrK1/Y5Fn
 b1ve+KRn8MQNgTE8YZla+c1QAc+X5aw6BQ+EEiWcDhmSoWiaaeu7wmCGwMuyhJR2VJJF3DXcE
 kfGT/KPTlCyjCEbcrFosEjy5nMnLOkvCbFwEAvVpxI+LAV2qynsekWPUw/0gRspwoZu/6T7/v
 XgAq6qRHYBR74vTGbjemKBv6yFsV107cAo7j8o2z3rERCGPby24SyF5cjkK4aUOKnRwxuSoX1
 ML5HeO6uW2kM0Wr4mV2rBEUfd7mZeSfnJ2S+yfBk9r9l8jys3oe/IRQ5535FgCTcye4+sN9nj
 B6B93WB6JvrFZ7hVC0IG5H3O7FfIoohCEhMLtaWSOzK3vx0r8Cjd8LPx+BnaR+bX5IFUIFZ44
 dxUdB0NCtvkTBykI4elb2DnU1AHtaqd7LgutR99ZvgqHCVX55KCUMctkclQDnHFdDf4KKrYL8
 q4/l5hjlkWtzZYsJ6213+aXldVDCK6J8vMsaU82U8mimsP9Q0kUTXQFMO/ZS0uOAPurwBDJHP
 VyLBSlcVCZDjVkKr0PxjvaxwzRsJ19D9Op0z7U+wmQvwfZi6azaMZ2L6ED8Plj3+7N+oEj3+k
 ymWxq6QTGfk0IfTqHPhlNqNgUmEC2/GzBLzPWPcNbOAV69sT3nPnSaiimLZk/WncRRn3hZizl
 LKnePmX9ZC3Q66TxAp57qX3iUQCaMI5Vs1XlJ00T6nzddSZaR31dT3iRlHdIxBuQy2/XKk3C0
 PzqUIweQ6uRcDxZV4fJ7i3/7KwKbLUeDZeI3THrdsNJ1jvSc/ooFQxf/b5L3JJy1PypohJ9YH
 4RhXIZBpABf/X9hoXxx+4eVrZJ5aNJFmD3SJrE4KGVJ6xSyd4thUrv7Bn4ZTZcfQWorno4GO4
 dKXg4iumqlAO7u9dciA2GEeEve5o1H8nizqD2DADR/wo8TqQgV13sIlnIRNt41mLnZ1caJIOQ
 NjSW44yHL+iFiMp99FbBlo0Azv9ePm3aqnkovdSkKK24blX3Vu/lteQbfyIYMrn2xCFqycvrp
 Ttnn4kusJlKG71Uoy0wLnlceTy4pb12JNVLF7EXZ6fOJuiPLJkE27AUTk2cv/CRNm2ExILYyp
 azLxCTGs7nOl7Q+nu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/tools/bootconfig/main.c
> @@ -314,31 +314,35 @@ int apply_xbc(const char *path, const char *xbc_pa=
th)
=E2=80=A6
> +free_data:
>  	free(data);
=E2=80=A6

Would any software users prefer to omit the memory release for
a quicker program termination?

Can the commit message become clearer about the explanation for
the importance of the proposed change?

Regards,
Markus
