Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874D1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E20922CAD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nZAzQ4lE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgHCUgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgHCUgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:36:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C44EC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 13:36:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o1so21571516plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2F9ZF9htCdgTGnye4Ms9Eo2tsmXq4m2N8BAkR3A5B7A=;
        b=nZAzQ4lE0whX3zEtFjMirYy1jTai9LIRNYptpFNQIjCWo8AAOs4xmbPjE47De0a5qx
         1EsgPv4wgg6wXYETK8ViL/AzUXsH0cNoEImvMSnZiOq02tskOrt+G4T0cyrI4nLxG2b2
         CIrG6txBS/AZZTrHr4aFKtBTbweOV0V/mcOSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2F9ZF9htCdgTGnye4Ms9Eo2tsmXq4m2N8BAkR3A5B7A=;
        b=YIASgel7bJPalqHmcmfbBk1WdZ2Z+j89EWTv6k1wldfa63NeKgWKZGOxkj03OgpzVf
         TxZvksSgLH2oOWOOYkuWzugaZVW3VP4gzg08WDYPHVPPaJXeRzT/Vm1G7pFcGNH2s4FE
         EcGrhjTAylRyU6ilUOAWR8XvzzKVesSouoyA7ZIS5ofsfPWemNJ/om9lE4ZBoW7rNKn2
         h5ACPRDRO9dWHnlkoWTxmPyIm15KDN06Eij2eXnEOMEz/QDcd+Ot3Ibtb/w3iZW/g0K4
         HnaAdvEgTQ9B+xvfSfoXlshur9S6u89FyUr+tzB40OxS9wisr/7Oi+qgk9/p2OcN5wpF
         J9lg==
X-Gm-Message-State: AOAM530YBahDxXJ8UKE/SFAgYqUiDKYx9XDtXOUCWwzzILC1bVD3U2oa
        NM6FZvib2DQl413+si1mse8v2Q==
X-Google-Smtp-Source: ABdhPJz6G+AwiYfQgKC8q1npJesqLu09L06PpCrBEdD/xFikahTomo49EV8Rt3o/r93GMMO1xhUHiA==
X-Received: by 2002:a17:90a:4488:: with SMTP id t8mr1023030pjg.191.1596486966811;
        Mon, 03 Aug 2020 13:36:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id na16sm336058pjb.30.2020.08.03.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:36:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200729051310.18436-1-saiprakash.ranjan@codeaurora.org>
References: <20200729051310.18436-1-saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv3] coresight: etm4x: Fix etm4_count race by moving cpuhp callbacks to init
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     coresight@lists.linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Date:   Mon, 03 Aug 2020 13:36:04 -0700
Message-ID: <159648696483.1360974.2828241668912900602@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-07-28 22:13:10)
> etm4_count keeps track of number of ETMv4 registered and on some systems,
> a race is observed on etm4_count variable which can lead to multiple calls
> to cpuhp_setup_state_nocalls_cpuslocked(). This function internally calls
> cpuhp_store_callbacks() which prevents multiple registrations of callbacks
> for a given state and due to this race, it returns -EBUSY leading to ETM
> probe failures like below.
>=20
>  coresight-etm4x: probe of 7040000.etm failed with error -16
>=20
> This race can easily be triggered with async probe by setting probe type
> as PROBE_PREFER_ASYNCHRONOUS and with ETM power management property
> "arm,coresight-loses-context-with-cpu".
>=20
> Prevent this race by moving cpuhp callbacks to etm driver init since the
> cpuhp callbacks doesn't have to depend on the etm4_count and can be once
> setup during driver init. Similarly we move cpu_pm notifier registration
> to driver init and completely remove etm4_count usage. Also now we can
> use non cpuslocked version of cpuhp callbacks with this movement.
>=20
> Fixes: 9b6a3f3633a5 ("coresight: etmv4: Fix CPU power management setup in=
 probe() function")
> Fixes: 58eb457be028 ("hwtracing/coresight-etm4x: Convert to hotplug state=
 machine")
> Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
