Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B054C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B86206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfIJBc7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgHDEhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgHDEhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:37:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA44C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 21:37:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f5so4144901pgg.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 21:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zqowAZufb7b0uKdkmkGlWSQC5Gld+DbUt3HuxK1ZIc4=;
        b=dfIJBc7J6lHjp36VIYX7blXf9z2V2tSLQMdoVnjvBngdeoL6iZ7Jhg+oA5/CheCqbs
         ZRCMZNeC6Dz1t66JAkwLD/Kzsw5QT72CRiDMITe7+Yx6es41aLi5xcl3IIs4Eu834zPR
         hL0o+ziAZRDSw9a6yedGgaNrLyAMbPAkFJnqs/R+DQn02JVl2ag0YGEl8KFxw2o0mS45
         19SeVyhm4H9JrJgBFrJ2zOKfRCdGI4IWNMEtdJjA6zSq60WYQUYIXslJi//TXVlkuB21
         7M/J4AElDdZx9THIamQhp0jk0rwCLHYgaHFol5zODsPuOK2lF4gVbIDWqZWbBuC08YKC
         OQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zqowAZufb7b0uKdkmkGlWSQC5Gld+DbUt3HuxK1ZIc4=;
        b=CEMz4T2TGzKWx9IIwEqxQFIy/smJ9MbxBRk6W2mowp9V5cg7g7C0LskgyNYJwZ0xPv
         M8zURCTM1xtJU2uHy3fpnfv+2rfUm36Vmk/Sy+U5eS0zxaCVuRt2AJyt7qoORx6QX9qy
         88JLRJdrJpjsF5RDJpQNTJZyWXdRwYdbMLLGVX9yJxhiPEfa6x54skBfQVx5js4Dgxxz
         Kn486Ltv/TtaEBSdgC9AkVmXesaSxD+XliqRehFkaXlipjPOvM1adDBtIAyUGibLtJ2H
         VsxUT/+5GVxkW9UhPcQCke5DL1Rr4j2/vomNTArd9VuXIHm8dW9AE+h8gF7r4rkkLo/y
         0LQQ==
X-Gm-Message-State: AOAM532Veljv86SjNUxf2hgNJWp+fFAdhIQ6csyXQzBQkrxDPX6zarcE
        AtyhLQMPwFqatUjYZ4vQAnMsSQ==
X-Google-Smtp-Source: ABdhPJyT1eg8U8v7kNE2LdnRYGrpRoiGECTB6MXZ62JuB7qooc12g5BQxjsZsuVcty2ibapVfbv5MQ==
X-Received: by 2002:a62:9256:: with SMTP id o83mr17696174pfd.44.1596515864280;
        Mon, 03 Aug 2020 21:37:44 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id j130sm139319pgc.76.2020.08.03.21.37.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 21:37:43 -0700 (PDT)
Date:   Tue, 4 Aug 2020 10:07:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq: CPPC: simply the code access 'highest_perf'
 value in cppc_perf_caps struct
Message-ID: <20200804043740.cde3ij2uk4xczemh@vireshk-mac-ubuntu>
References: <20200701042007.13333-1-xhao@linux.alibaba.com>
 <8643d122-c069-192e-8f3a-dc18f84eed9a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8643d122-c069-192e-8f3a-dc18f84eed9a@linux.alibaba.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-08-20, 10:37, Xin Hao wrote:
> Hi everyone:
> 
> I want to know why my patch didn't merge into upstream ?

I have sent a pull request earlier today to Rafael and this will get
merged in the next pull request Rafael will send to Linus.

-- 
viresh
