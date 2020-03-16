Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E56DC3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C33205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fIiUBq1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbgCPWKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:10:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38823 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732723AbgCPWKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:10:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id z5so10728978pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lsN7EIok/ouPxtEONuI3O/CpHJW1h0sdrosta3mQ6+A=;
        b=fIiUBq1l01hYj8p+vHzAisWXU9WUJrxuIHL1WZZBr7bUPM4xYemJmTHH/vqXERaXKh
         E2SpAdwsDs45Vd7CWKG6PIrvPKxgKFz7xe4YPbTZII9CAAwI/Va6Rk1/JJiFd+4c1BcH
         f5MSctYqJlExETlAgfMwtlywD/0xD4HXhZD0+q/SGh4U26sP1XCjGvUZinrMJRfzEel0
         2zFYZmlthBNJV5sXYCjoPs72+POB3wWsZYU2KS1QJjfbvI4GEahFgSDYVOk/Z6EYYOR7
         KYgZ68368ZqtjVvi41XIIiT6jiKRciplcvu4IzVZ9IkGPHiJSs5lUddoyZZo2V047dbm
         YScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lsN7EIok/ouPxtEONuI3O/CpHJW1h0sdrosta3mQ6+A=;
        b=NesPZsdNb4zYFz5lBJeYbgPYqbum99zbqvJaHG3ZpVu2E2byRjWNtpObYZ0dQ53vXu
         ZMDZPgRkB087AGicfRJYxVino8ZjVhnbibAc58GJ60oW8HHmO4dz7dtst3ljUsbWVbP0
         I7XMeMy5o4DiNVH3hVOoWLLGOa98f9rNw+QL7SEa12diUPQiqA3VQi99hP9nP1DCvaIb
         KcpPxTwC8mWVIpTSwc70QJdvBJUzK5kIFH9hECR6dtlEWxplCwLi69s7UvusKpjMCYQR
         +zMnaiPHDE960epq0FOJCkE3kXGsDsIKX+wuMCbSvaRrHYPhrI0H+KhvqfE12KiHC3yj
         Fxug==
X-Gm-Message-State: ANhLgQ2g4S+tvMCVwjP/Jl2yvMQHEHiTA0/M9EFiFnYh3pb0/XZ9PqQB
        KsXwC8i6ReIFPkbplK5RENKpVw==
X-Google-Smtp-Source: ADFU+vvRZTokbXDvAMeIciVBdT0hLnacvxrbIHnxTebxVa++fTVhf8IiwkpdOSqi4cln8SxcNU9oBQ==
X-Received: by 2002:a63:348b:: with SMTP id b133mr1961463pga.372.1584396635461;
        Mon, 16 Mar 2020 15:10:35 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s20sm809439pfm.154.2020.03.16.15.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 15:10:34 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:10:32 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: linux-next: Tree for Mar 16 (drivers/soc/qcom/)
Message-ID: <20200316221032.GF1214176@minitux>
References: <20200316183039.0d1c45ce@canb.auug.org.au>
 <4bf2d095-e416-7e39-b514-3a1a9b4248dd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf2d095-e416-7e39-b514-3a1a9b4248dd@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 Mar 10:34 PDT 2020, Randy Dunlap wrote:

> On 3/16/20 12:30 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200313:
> > 
> 
> on i386 or x86_64:
> 
> WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
>   Depends on [n]: NET [=n]
>   Selected by [y]:
>   - QCOM_PDR_HELPERS [=y]
> 
> causing:
> 
> ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_new_lookup':
> qmi_interface.c:(.text+0xd3): undefined reference to `kernel_sendmsg'
> ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_new_server':
> qmi_interface.c:(.text+0x1b6): undefined reference to `kernel_sendmsg'
> ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_sock_create':
> qmi_interface.c:(.text+0x2f2): undefined reference to `init_net'
> ld: qmi_interface.c:(.text+0x2f9): undefined reference to `sock_create_kern'
> ld: qmi_interface.c:(.text+0x319): undefined reference to `kernel_getsockname'
> ld: qmi_interface.c:(.text+0x33e): undefined reference to `sock_release'
> ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_message.isra.4':
> qmi_interface.c:(.text+0x45f): undefined reference to `kernel_sendmsg'
> ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_data_ready_work':
> qmi_interface.c:(.text+0x7dc): undefined reference to `kernel_recvmsg'
> ld: qmi_interface.c:(.text+0x877): undefined reference to `sock_release'
> ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_handle_release':
> qmi_interface.c:(.text+0x1018): undefined reference to `sock_release'
> 
> 
> 
> 
> All caused by QCOM_APR, which selects QCOM_PDR_HELPERS,
> and that one selects QCOM_QMI_HELPERS, which depends on NET, but:
> # CONFIG_NET is not set
> 
> Full randconfig file is attached.
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Thanks Randy, I've added the necessary dependency for QCOM_APR.

Regards,
Bjorn

