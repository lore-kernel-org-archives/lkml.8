Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11923C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAD020721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbnfzkIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgEEEp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgEEEp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:45:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B4BC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:45:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x10so330629plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WQdaOF3XQSbF7ISZqxOpNe4/bVfW3pqgrZ0j9lY0eXo=;
        b=mbnfzkIq2VHRPKE79M1AQNDRBhJEA/M2E/sj47V3vpWkvWALWTf5V+nHTTT5lMiK8I
         0xU/fKF8LbXtbIHkt+0+TaiXWUV+bsUQblaHk6izZHl71KxxBS4gyTs8npiHaTX4kgQS
         UuA/FZwt9bqVAPrbGjpU/WfnRl79ymFv4Jz521bS5HlE9XiEhwd2iPxS+RAIBSb8Q3Cr
         +RCONhK4cYh3ZvAwxsb0gvGVkFhxls9KXhTa8h9u/Mzt8q2rN3f4+7W0yhcGUfsB3/DW
         cQThNnDbFoXxkkSqA35eMlDQLt7KsSXydjwNMJ8N1F9QiC/eYjQpSGX5se/EmWt0oIJu
         DlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQdaOF3XQSbF7ISZqxOpNe4/bVfW3pqgrZ0j9lY0eXo=;
        b=Avbk0S5AlI9q6JJiTbFwsybysPdDZPGoyUNqDwDyMUbLn2S9ObVqs6ma2WoSMR5pXk
         lQwnEFAvzdoWdj3s911yioUBzr/ej7ET6rvc0dyBtA1k6LZE4YtJiDsq4olpySxbif70
         i7Hr2BRS113y9423EEHAFW8UV1owwqbaGlxZ2J9UnltlyYgGiHk0xxmfJBd0HQILamjP
         LEfHfuI9Hit1TS09StBagWlEBRt8y1RrH4XsP3VA/9USicVDEpLth1RwNZsD4skDjYTa
         69MxripNkPdKEoYfZ41MX3QVwuBlvVrNUg3AwHcUdp5AowTJmNRdLDP39QSFky+2TW49
         bdDw==
X-Gm-Message-State: AGi0Pua8Ry0jskvTUuxWoV4xG4027H5/KHmaiqUUjwQUwVAJ0oVo8ZjP
        Ku9gDTtnEuc/lRZd1dyN0ZPV6UY7Huw=
X-Google-Smtp-Source: APiQypJKwkzEe2YEV3s3rKITy+pzVVkhX/S4i2dXau2NKr4QNkAiq/gJNcmTAx+s3mpLrvqE9S3cmQ==
X-Received: by 2002:a17:90b:80a:: with SMTP id bk10mr687187pjb.135.1588653955706;
        Mon, 04 May 2020 21:45:55 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id w1sm531677pgh.53.2020.05.04.21.45.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 21:45:54 -0700 (PDT)
Date:   Tue, 5 May 2020 10:15:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, saravanak@google.com, mka@chromium.org,
        nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 04/12] OPP: Add and export helper to update voltage
Message-ID: <20200505044552.3dejhryk6fhypolm@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504202243.5476-5-sibis@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-20, 01:52, Sibi Sankar wrote:
> Add and export 'dev_pm_opp_update_voltage' to update the voltage of an
> opp for a given frequency. This will be useful to update the opps with
> voltages read back from firmware.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Have a look at dev_pm_opp_adjust_voltage().

-- 
viresh
