Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840AE207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgERJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:30:41 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45503 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:30:41 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N30VJ-1iwITr3ZlN-013KC9 for <linux-kernel@vger.kernel.org>; Mon, 18 May
 2020 11:30:39 +0200
Received: by mail-qk1-f174.google.com with SMTP id i5so9362828qkl.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:30:38 -0700 (PDT)
X-Gm-Message-State: AOAM531vErg581ItIlIbXLYBJUgawe5hU1rIIPJIWAmonQGyyCRYRcZ+
        iCw2jXqNaYzNZO+d5WnwVu2wMeJw0Q2+4Cxg240=
X-Google-Smtp-Source: ABdhPJxRqWQIj9CjL9GR9FsX53141b4RwqeRLWTo40Ql7QOtN7iteNEnTf9KKJLcV8J+ZKUnKb5gG3rk3PdK7Chz1lE=
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr14877840qkg.394.1589794237799;
 Mon, 18 May 2020 02:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200518091222.27467-1-sudeep.holla@arm.com> <20200518091222.27467-8-sudeep.holla@arm.com>
In-Reply-To: <20200518091222.27467-8-sudeep.holla@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 May 2020 11:30:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a20R+H6m5GZj2_0w3s-xF+J_qSVrQH8EjyQXe6+9WTYxw@mail.gmail.com>
Message-ID: <CAK8P3a20R+H6m5GZj2_0w3s-xF+J_qSVrQH8EjyQXe6+9WTYxw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] firmware: smccc: Add ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        harb@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HZubW3EcYdXsdU11J3kNXOpT7zY8kXCxBtl6oOPgRK6AVl1UAkb
 uC4N/aGNszqVreLRS2AEf6BmmVN52veXmJi//gA0Rrxix7FisldM2ZsxDxbipFU/ZsJPn+2
 Dt8/+6pAyIUJSnlfnk2YcJDiXWbkDgtpefSHnRsJzmHDMe/qQ4a9nmeAZvcRCXqhEcLeKRN
 se/YWgXx7ktVkWeIeqh5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VGXT3xbwVaQ=:roa4Clbkc9i3Mb5gAgWh54
 hBoLaLwefpiZJAal7DfXniL/VWqrrUGyBEl8iKSkQxPasaUV/gOD+enCk9PPDsrtzUtqZu6Qh
 zFbq9fvUOMDvXfq5kEoGTzTO+bsT/UdUo9Ori9M1P+oO7LigLTey8uJRid6Xz5xgUivDaL2zc
 If7SXV9GeAdSlwRXug0V9UX64/bkDGyKvzHHFD77EryxZA/g7EVcauKm4p3258frcYkwbbhlL
 P7WhLDfhEfoz+80xE2iwJH4D5GzYTsQ7eQ/etRWXmYlQQqCUW+bZ7+I4xx/tE4pq4FtLIXMxW
 pXOAtG6TVx1iB6YtEiqmDXDJajdzAF1zRi/VgkfOPBTGMFxQ0D0fcsZZwl8zQLtHyLUiaLxKK
 YprXuOgSc7xZGBZDEPzHLX7hdXnosTN6VZ+67Ya/ClsyIchE0QXlhs3A81qSGm0s807TTAcTq
 qEe3hnt416TZUtePd1P8kVcNXuFZGNA7IsAwBwdhuHG+MczooSX36cdjjHmC0/8mLVNtn0+yo
 5Sgtt0Izll9CVKRrPtCzGAovioVik7lAXqw0gW31HFyoQ5+FIX9IVFVIqbM1ZUQFkZo6+vXCz
 ZV2Jsk6BTQPR6b89ET7f+y62MG/44FrgEz2VrFICeg6o8pZJtnA471iFOl8+/yHIuRv+6VMc1
 tGyN17AlRGfhQrV+aGLCPZsLduNnarD9BgYRSGGsJb1ljfe71ji5Oz+YNjXmGS0O+RmcKd0Zc
 76suxu/7B2zdWHTIbvjrWySeeGBqbyzOkJKuqSQCah6qhUalT3dM9tiF97bltuiKB0IwJ/29k
 ZQjHjH2JI3xX46CtOky9riQ10iqzUF6CQ7CsfY6jdWgSANYxCs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:12 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

> +static ssize_t
> +jep106_cont_bank_code_show(struct device *dev, struct device_attribute *attr,
> +                          char *buf)
> +{
> +       return sprintf(buf, "0x%02x\n", JEP106_BANK_CONT_CODE(soc_id_version));
> +}
> +
> +static DEVICE_ATTR_RO(jep106_cont_bank_code);
> +
> +static ssize_t
> +jep106_identification_code_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "0x%02x\n", JEP106_ID_CODE(soc_id_version));
> +}

I think we should try hard to avoid nonstandard attributes for the soc device.

Did you run into a problem with finding one of the existing attributes
that can be used to hold the fields?

       Arnd
