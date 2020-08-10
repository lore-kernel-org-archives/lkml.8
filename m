Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17A4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8941220829
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZuH1bRlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgHJQTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:19:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53039 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgHJQTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:19:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200810161918euoutp02384d1cdf9682814a19ece9ee0375e87b~p9HxmBsxb1253312533euoutp02J
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:19:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200810161918euoutp02384d1cdf9682814a19ece9ee0375e87b~p9HxmBsxb1253312533euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597076358;
        bh=fQpqVRukjFwXato5hWiSMNWbmM4mkmN49H5yReXM2hA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZuH1bRlpbqrLTPWQNhFxv0ARMvwqzUA6clJw876ceDAuIHXTVFP94rjtmmloUcwrS
         jvfDcmzVr6Es1H9CFNmvdqPYuvhdwiimQ0Z4sFI/WyrkyeGdZl2nxXdc7IwsURCp1M
         seRFKKDV40+qQG+fk8uK4YbZfS9CWnS86Yn1LNGY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200810161917eucas1p16c02187100dd71f8cafe62950aa63e8a~p9HxI8fxt0149501495eucas1p11;
        Mon, 10 Aug 2020 16:19:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A1.27.06456.583713F5; Mon, 10
        Aug 2020 17:19:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200810161916eucas1p22c6e8c9488194bec4cb7198a416e24fd~p9HwDFisd2971829718eucas1p2I;
        Mon, 10 Aug 2020 16:19:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200810161916eusmtrp23a51452d6bad9cb77bcc3dae202516f7~p9HwCgCEs2878128781eusmtrp2t;
        Mon, 10 Aug 2020 16:19:16 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-d4-5f3173850c20
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FC.E8.06017.483713F5; Mon, 10
        Aug 2020 17:19:16 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200810161915eusmtip2a378c927ee9f676763e6ea2365d6660a~p9HvZytQT1832518325eusmtip2-;
        Mon, 10 Aug 2020 16:19:15 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: Prevent potential endless loop in the PLL
 set_rate ops
To:     Stephen Boyd <sboyd@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Cc:     COMMON CLK FRAMEWORK <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mike Turquette <mturquette@baylibre.com>,
        SAMSUNG SOC CLOCK DRIVERS <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <6736f3d1-31de-6be4-2b1b-50c776025b72@samsung.com>
Date:   Mon, 10 Aug 2020 18:19:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159683164115.1360974.9195158180168134577@swboyd.mtv.corp.google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe7dztqM2eZ2GTxYKoz6Y5BwWHFG0mzikD93og6Jr5slL25Qd
        NRUiQRSdl7wE6tA0JYyFiOZdshrq8E6mJc5Z1EgqrOYlskxzO0Z++/2f5/+8z/OHl+KLO0kv
        KkmTxmg1SpVE4Ex0DW9MHs9jZYqARctBuq26laTfrC2RtK14kaRf9dUK6OqpAR7dMmgR0i9H
        w+mt120EbejbRKec5N/m8oTyXr1FKG83FArkpR0GJF9t975ARjmHxDOqpAxGKw295pyYX/WA
        TNXhzJrN5By05aJDThTgE7Aw0yHQIWdKjB8hMNTq+ZxYQ7Bq2xByYhXBeME4+jcyZ/6y22hG
        YDYYCU7YEAx9XCXtLnccDQ8tVXw7e2A5DC7+IO0mPjbzYPRpi8MkwDIoGSp1PCvCoVDcPegY
        IPBRKLIZBXY+gGOh0zTL4zxuMFJjJezshC/B1MiEg/nYE+at9TyOfaB7udYRAvCoECrv6gju
        7nOw0LIs5NgdPps6dvkwbPfah+0DuQiK+81CTpQheGtq2E0dDAuTv3ZOonZW+EJrn5Qrn4bp
        93V8exmwK8wtu3FHuEJFV9VuWQQF+WLOfQR+G6p4HHtBkXWbKEMS/Z5o+j1x9Hvi6P/vbUCE
        AXky6aw6gWFlGuaWP6tUs+maBP/rKep2tPOZxrZMKz1ofTrOiDCFJPtFqcEyhZhUZrBZaiMC
        ii/xEJ2ZGIsVi+KVWdmMNkWhTVcxrBEdogiJpyiw8VOMGCco05ibDJPKaP91eZSTVw7SP5sP
        UnkP+kXEGnKvNAUoCs+j1jvSn1qXsMp679n6lPXo2t6LJXHNf+oTozxu6zpDNPduVLyYMH9/
        7h81nFx3/+xVP2tbTk72yYgZ3Fh3WVSe+YEJD/IdHY/0tvaENcx2qWLUVLy5zudJoO9jy7vG
        YWpJGlnevxK59jXLtK9pQEKwiUrZMb6WVf4FruLNZEgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7otxYbxBseWC1hsnLGe1eL6l+es
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi37WNLBardv1hdOD0eH+jld1j56y77B6bVnWy
        efRtWcXo8XmTXABrlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpO
        Zllqkb5dgl5G2/SFrAVdAhUz/2Q1MP7j7mLk5JAQMJG4cfs1excjF4eQwFJGiS9LrrB1MXIA
        JaQk5rcoQdQIS/y51sUGUfOeUWLqwfssIAlhgWiJpXenM4PYIgIeEkfufWMFKWIWuM8k8aT3
        OTtIQkjgEpPEok4rEJtNwFCi92gfI4jNK2An0bP9CFgzi4CqRPfHQ2wgtqhAnMTj3v/MEDWC
        EidnPgFbxikQJHH+5Fkwm1lAXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJqFpH0WkpZZSFpm
        IWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAKtx37uWUHY9e74EOMAhyMSjy8BdaG
        8UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxggsgriTc0
        NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cDobzS3cSVbrNOEsOUNBvuy
        +Vcnuf76Wf7z543zqa9tHyi9ueZx6sTxudxPZk64z/t70fMFkncM/sezTvnosk/unoiQoP+U
        0nfHP7z8dqRw8dS+W7UdLy5dus5ymKnt0f1Zf61Fdd8pr8tQOrJm1vntO6qv/f79e4vKbb1U
        M5/IT58Xict96D62a7YSS3FGoqEWc1FxIgCmTylw2AIAAA==
X-CMS-MailID: 20200810161916eucas1p22c6e8c9488194bec4cb7198a416e24fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f
References: <CGME20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f@eucas1p2.samsung.com>
        <20200806160646.1997-1-s.nawrocki@samsung.com>
        <CA+Ln22HGSj4gFRmw1rSLaTvw3TiPC9jaM6JB4Z1fbxpwsWNZWw@mail.gmail.com>
        <d980e369-73ef-89a8-6669-f7e9c5dd3243@samsung.com>
        <159683164115.1360974.9195158180168134577@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.2020 22:20, Stephen Boyd wrote:
> Quoting Sylwester Nawrocki (2020-08-07 10:06:08)

>> On 8/6/20 18:11, Tomasz Figa wrote:
>>>> --- a/drivers/clk/samsung/clk-pll.c
>>>> +++ b/drivers/clk/samsung/clk-pll.c
>>>> @@ -63,6 +63,27 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
>>>>         return rate_table[i - 1].rate;
>>>>  }
>>>>
>>>> +static int samsung_pll_lock_wait(struct samsung_clk_pll *pll,
>>>> +                                unsigned int reg_mask)
>>>> +{
>>>> +       ktime_t timeout;
>>>> +
>>>> +       /* Wait until the PLL is in steady locked state */
>>>> +       timeout = ktime_add_ms(ktime_get(), PLL_TIMEOUT_MS);
>>>> +
>>>> +       while (!(readl_relaxed(pll->con_reg) & reg_mask)) {
>>>> +               if (ktime_after(ktime_get(), timeout)) {
>>>> +                       pr_err("%s: Could not lock PLL %s\n",
>>>> +                               __func__, clk_hw_get_name(&pll->hw));
>>>> +                       return -EFAULT;
>>>> +               }
>>>> +
>>>> +               cpu_relax();
>>>> +       }
>>
>>> Thanks for the patch! Good to have this consolidated. How about going
>>> one step further and using the generic
>>> readl_relaxed_poll_timeout_atomic() helper?
>>
>> Might be a good suggestion, I was considering those helpers but ended
>> up not using them in the patch. The cpu_relax() call might also not be
>> really needed now, when there is the ktime code within the loop.
>> Having multiple occurrences of readl_relaxed_poll_timeout_atomic() could
>> increase the code size due to inlining. How about keeping the 
>> samsung_pll_lock_wait() function and just changing its implementation?
> 
> None of these concerns are mentioned in the commit text. And they seem
> like problems that should be addressed if they're actually problems vs.
> avoiding a common macro and not mentioning them.

Sure, I will improve the commit text, I just didn't investigate in detail
how the common macro could or could not be used before Tomasz's review.





