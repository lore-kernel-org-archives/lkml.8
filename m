Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1F8C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB7320720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B3Fuj2xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbgEKTha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731540AbgEKThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:37:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB65CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:37:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ms17so8274219pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4+TfwVXKgl+kCzrXzLvbtXwZoeSbQHCRrZFbCPATzF0=;
        b=B3Fuj2xS9vF2SEGI6Xmh49i0Ps/UE5wXP9tUU9qj2fDX2G7Lxv+YRKSOPuyDvlddDv
         ETcNZUmUS6KMOMSzB6bUc05QWaHt7YMuedWyW3+xvmAgD7PeLLqzn6wklbmQDOlW4pv8
         EvawUg2xIJvv+bBu0oGoC582VWszan8PBlTCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4+TfwVXKgl+kCzrXzLvbtXwZoeSbQHCRrZFbCPATzF0=;
        b=szU8KE7JhwXl276zQ4F1rUSzf6QoOkm6WjkwNl1utOGAalWjb9nMxXR+ipikHo82EO
         wr/iXW4f0uaq87Szf1XDISnuEn0vgBA8ZVZIzqwdGiCVmkRKXp/IGdgvdSORAx7lSXO3
         peiPX42pd8S8/Y8N+wHEQTdZfQo9R7/diAQPhGDFOkfdyltG62xXQYknKbFhQegQSsY3
         Lobl4K4MPWn9VxL/eGijGDAobJ0a5EW5NzYjlZlMa+prqQHY6Ct9VaqMSHpa4JEVSYkd
         ZiJWEOQE3NxrAQgQmMj/vG41ltsqoG4vOYHCzXw+GITK/GxA2LWASbOXz3i/1EaB7yZW
         QqPg==
X-Gm-Message-State: AGi0PuZTJaAJfcLjaCfLU8ZrUJM3JX2yN27X3D7Nst3BMCE09BIY76bq
        T3WUz1zJAZPsPumM3+39c5EUKw==
X-Google-Smtp-Source: APiQypIcUFafUBeCy0rKTAZwm5qMdMe4CvAczlQJ0wpJxs6R6jWIuAB1kzwSF1szCKdbLPDVD2RDyA==
X-Received: by 2002:a17:902:8688:: with SMTP id g8mr17323717plo.268.1589225831184;
        Mon, 11 May 2020 12:37:11 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id cv21sm11083259pjb.23.2020.05.11.12.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:37:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200511175532.25874-1-sibis@codeaurora.org>
References: <20200511175532.25874-1-sibis@codeaurora.org>
Subject: Re: [PATCH v6] iommu/arm-smmu-qcom: Request direct mapping for modem device
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        evgreen@chromium.org, mka@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org
Date:   Mon, 11 May 2020 12:37:09 -0700
Message-ID: <158922582972.26370.14084228362776489859@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2020-05-11 10:55:32)
> The modem remote processor has two access paths to DDR. One path is
> directly connected to DDR and another path goes through an SMMU. The
> SMMU path is configured to be a direct mapping because it's used by
> various peripherals in the modem subsystem. Typically this direct
> mapping is configured statically at EL2 by QHEE (Qualcomm's Hypervisor
> Execution Environment) before the kernel is entered.
>=20
> In certain firmware configuration, especially when the kernel is already
> in full control of the SMMU, defer programming the modem SIDs to the
> kernel. Let's add compatibles here so that we can have the kernel
> program the SIDs for the modem in these cases.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
