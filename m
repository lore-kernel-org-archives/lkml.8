Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34326C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F21F32086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CJ/qLf9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgHGRGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:06:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40514 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHGRGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:06:11 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200807170610euoutp021ef7cd32503e56aad585507b54a89d31~pC01wTJ8P0351303513euoutp02R
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 17:06:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200807170610euoutp021ef7cd32503e56aad585507b54a89d31~pC01wTJ8P0351303513euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1596819970;
        bh=ySlo1rRurySUq/mJUjWBrCBKqPIR44VZIR5xfff2xc0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CJ/qLf9mT+oJ0m3nkPwzytd+7LjgFY8NeWbXhY4/AlmUu1Ue2gt3SvlU/s8UmYfAx
         zvQVS8r9CMqppgi3Hxaj1L5WVkniTK0IctcBlNoAL4S6VM89facVyD5eSUP8GH2q/o
         dtr4oPnZDQ1aWSkMj7I8tHvKAQD79mQQeMQfuxxY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200807170609eucas1p163ca3c0f6a466a038de9b9affa345011~pC01WyY3n3153631536eucas1p1Z;
        Fri,  7 Aug 2020 17:06:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 59.DA.06318.10A8D2F5; Fri,  7
        Aug 2020 18:06:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200807170609eucas1p1589506c27a99349d174c6c4c29e84288~pC005XIap2084920849eucas1p1d;
        Fri,  7 Aug 2020 17:06:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200807170609eusmtrp2fabd780e21b12cbcd998e857599fdf14~pC004qkxC3033030330eusmtrp2E;
        Fri,  7 Aug 2020 17:06:09 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-43-5f2d8a01c8a9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FB.66.06017.10A8D2F5; Fri,  7
        Aug 2020 18:06:09 +0100 (BST)
Received: from [106.120.51.75] (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200807170608eusmtip2ed8565facc73fccd2acc5b0e8aee273a~pC00fBSfA0703507035eusmtip2M;
        Fri,  7 Aug 2020 17:06:08 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: Prevent potential endless loop in the PLL
 set_rate ops
To:     Tomasz Figa <tomasz.figa@gmail.com>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <d980e369-73ef-89a8-6669-f7e9c5dd3243@samsung.com>
Date:   Fri, 7 Aug 2020 19:06:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+Ln22HGSj4gFRmw1rSLaTvw3TiPC9jaM6JB4Z1fbxpwsWNZWw@mail.gmail.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djPc7qMXbrxBiu6VC02zljPanH9y3NW
        i48991gtLu+aw2Yx4/w+Jou1R+6yW1w85Wrx79pGFotVu/4wOnB6vL/Ryu6xc9Zddo9NqzrZ
        PPq2rGL0+LxJLoA1issmJTUnsyy1SN8ugStjzdvigpk8FQf37WRsYHzO0cXIySEhYCJx6c1f
        xi5GLg4hgRWMEuu3nGSDcL4wSnx78psZwvnMKNF09TYzTMuSxstQLcsZJfZMOQ3lvGWUmDF7
        OyNIlbBAtMTSu9PBOkQE1CW+TelnByliFpjNLPFsxwl2kASbgKFE79E+sAZeATuJNdNPsIDY
        LAIqEle2HAeLiwpESux8+pIdokZQ4uTMJ2A1nAKBEt0N31hBbGYBcYmmLyuhbHmJ7W/ngN0t
        IXCMXeLEnidsEHe7SBw+dZkJwhaWeHV8CzuELSPxf+d8JoiGZkaJnt232SGcCYwS948vYISo
        spa4c+4X0CQOoBWaEut36UOEHSUuPZrLDBKWEOCTuPFWEOIIPolJ26ZDhXklOtqEIKpVJH6v
        mg51gpRE95P/LBMYlWYheW0WkndmIXlnFsLeBYwsqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS
        83M3MQIT0+l/x7/uYNz3J+kQowAHoxIP7w9f3Xgh1sSy4srcQ4wSHMxKIrxOZ0/HCfGmJFZW
        pRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cDIzZf3aefXaQZ3RHe9
        zXRNl5jvwZv0RtDHyNf8lcHHmsiKQAP/4nPz9Qw+PNRUKLqjObHv0mNj681ix7OSGANevLm6
        SrtRxEyiQ/O6g2HzhuM8VzoWfb/edj7zGH/Ojb1G8mHdN7Rqkuynbrr67+LEJ5t+5cftKP/4
        5UrnOZ16JfsNldc8kzmUWIozEg21mIuKEwHCX6FNSAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7qMXbrxBjtWcFhsnLGe1eL6l+es
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi37WNLBardv1hdOD0eH+jld1j56y77B6bVnWy
        efRtWcXo8XmTXABrlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpO
        Zllqkb5dgl7GmrfFBTN5Kg7u28nYwPico4uRk0NCwERiSeNlxi5GLg4hgaWMEk+aPjF1MXIA
        JaQk5rcoQdQIS/y51sUGUfOaUWJR/1dWkISwQLTE0rvTmUFsEQF1iW9T+tlBipgF5jNLLH+/
        hx0kISRwlVHi9rdQEJtNwFCi92gfI4jNK2AnsWb6CRYQm0VAReLKluOMIItFBSIldu6whCgR
        lDg58wlYCadAoER3wzewvcxAu/7Mu8QMYYtLNH1ZCRWXl9j+dg7zBEahWUjaZyFpmYWkZRaS
        lgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY3DbsZ9bdjB2vQs+xCjAwajEw7vAWzde
        iDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYF+m8gsJZqcD0wPeSXxhqaG
        5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGKsPbC/3O6K0XKKHbcfaLd+/
        rd/EGfdl/aa3791effnx8tqOU/PYypUve0f+7KmcvJXD8OBlwz//w2+JsusfvHl/5h+lGy1r
        xK3/LIsrU39xiKPzlvVj1Tadr8vuCwlabcqd7rZyf2WdL7+9RP9n5vf2Td+u6S8R6fj7mfPM
        xa4Wv6nblFZ1i/1TYinOSDTUYi4qTgQApKSnBdcCAAA=
X-CMS-MailID: 20200807170609eucas1p1589506c27a99349d174c6c4c29e84288
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f
References: <CGME20200806160653eucas1p2b7fd860f5d89589cf9df0ad0f8d3981f@eucas1p2.samsung.com>
        <20200806160646.1997-1-s.nawrocki@samsung.com>
        <CA+Ln22HGSj4gFRmw1rSLaTvw3TiPC9jaM6JB4Z1fbxpwsWNZWw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 8/6/20 18:11, Tomasz Figa wrote:
>> --- a/drivers/clk/samsung/clk-pll.c
>> +++ b/drivers/clk/samsung/clk-pll.c
>> @@ -63,6 +63,27 @@ static long samsung_pll_round_rate(struct clk_hw *hw,
>>         return rate_table[i - 1].rate;
>>  }
>>
>> +static int samsung_pll_lock_wait(struct samsung_clk_pll *pll,
>> +                                unsigned int reg_mask)
>> +{
>> +       ktime_t timeout;
>> +
>> +       /* Wait until the PLL is in steady locked state */
>> +       timeout = ktime_add_ms(ktime_get(), PLL_TIMEOUT_MS);
>> +
>> +       while (!(readl_relaxed(pll->con_reg) & reg_mask)) {
>> +               if (ktime_after(ktime_get(), timeout)) {
>> +                       pr_err("%s: Could not lock PLL %s\n",
>> +                               __func__, clk_hw_get_name(&pll->hw));
>> +                       return -EFAULT;
>> +               }
>> +
>> +               cpu_relax();
>> +       }

> Thanks for the patch! Good to have this consolidated. How about going
> one step further and using the generic
> readl_relaxed_poll_timeout_atomic() helper?

Might be a good suggestion, I was considering those helpers but ended
up not using them in the patch. The cpu_relax() call might also not be
really needed now, when there is the ktime code within the loop.
Having multiple occurrences of readl_relaxed_poll_timeout_atomic() could
increase the code size due to inlining. How about keeping the 
samsung_pll_lock_wait() function and just changing its implementation?

-- 
Thanks,
Sylwester
