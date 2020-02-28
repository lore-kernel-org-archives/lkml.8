Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9953C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB75246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXGNUb/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgB1Fe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:34:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41733 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1FeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:34:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so784322plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 21:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ABqkN8aqbIHHq6CJCYzSzg/UYqF9PzEXTXmM8ircYdE=;
        b=iXGNUb/uZGGZqE9qRVAQdGFZFVitoGfbTVoTeXp/0CB2r/Z0qwh/bwxklZ8Q7cYuYu
         2RvKwC+gehTtiwjrX9jbCYozOL3ChBhd1Kk3XsFae6+/t1mv1cuKZaxn0SHr35igPDM0
         iD5x2VXAOPlIZRmR7UOjDeRw2xcQ08RE5Yxos0yuMbCP3QTNw13nVM5uGGN6Xfd1lah3
         0/zD5Ld7dZHKAMnYLF1TTkaiei2a+VS3yzeHB5RQBu+io9m5rPvEqKUk1XoMAhTvvpvG
         skvYMD5yyrwEzGpvtm9J/S1H/8xBe7TmBoTUK4kDL95kYI2r0OhDV676MwAPh+B+ptvn
         Svbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ABqkN8aqbIHHq6CJCYzSzg/UYqF9PzEXTXmM8ircYdE=;
        b=OJxp4o6hTsGqsY++LI7O8frCqwxPK5X93Pyf8jk6axNdZur3h+hJUiYXiwgIeaRz/B
         HtAKx1vX3C1xYzkkbd+GYQEqsywmjOgVxF+yx1yhqqSdTYtKriBaBWc8w82T4F5xH8sS
         BJb23WB7xeWpBQQ79FWC2Ytf7PGLfH5Ug95ctDW0Ccaje0ro1nqZ2U8DWXi2dnmQsrmE
         Tqy92lZ16TwXsVE/V+RKWBr65xOr34DSJZ5THMSDhB/NtXCXrf63WAUqMA+bYCDBDzNm
         sXpJAwsF/2hPcbVYSOim8T77URJDT/NatgjrhbqiOF9jnmL248N+8RLQGUpXtqNJjlNr
         SspQ==
X-Gm-Message-State: APjAAAVF4mKmJo8onI7A9fCzON2mkOKtDcNrlH527R/eEeEGTErmMENC
        bYqE2BaSiMeN0NwcGUJNIBLDIQ==
X-Google-Smtp-Source: APXvYqwCds92WSgOcATJjPe5GOxHNR3RIEXkjbscjsxcH0l7rplY2Ca6nLAzVaRD/jXZ+Ny7BqZg2w==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr2408012pla.17.1582868064152;
        Thu, 27 Feb 2020 21:34:24 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q13sm8659550pgh.30.2020.02.27.21.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 21:34:23 -0800 (PST)
Date:   Thu, 27 Feb 2020 21:34:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tsoni@codeaurora.org, vnkgutta@codeaurora.org
Subject: Re: [PATCH v4 1/3] soc: qcom: Introduce Protection Domain Restart
 helpers
Message-ID: <20200228053420.GC210720@yoga>
References: <20200226170001.24234-1-sibis@codeaurora.org>
 <20200226170001.24234-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226170001.24234-2-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26 Feb 08:59 PST 2020, Sibi Sankar wrote:
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
[..]
> +config QCOM_PDR_HELPERS
> +	tristate
> +	depends on ARCH_QCOM || COMPILE_TEST

As discussed on one of you other patches, please omit the depends on for
Kconfig entries that are not user selectable. Presumably anyone
selecting this option will have ARCH_QCOM met already.

> +	select QCOM_QMI_HELPERS
[..]
> diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
[..]
> +static void pdr_locator_work(struct work_struct *work)
> +{
> +	struct pdr_handle *pdr = container_of(work, struct pdr_handle,
> +					      locator_work);
> +	struct pdr_service *pds;
> +	int ret = 0;
> +
> +	/* Bail out early if the SERVREG LOCATOR QMI service is not up */
> +	mutex_lock(&pdr->lock);
> +	if (!pdr->locator_init_complete) {
> +		mutex_unlock(&pdr->lock);
> +		pr_debug("PDR: SERVICE LOCATOR service not available\n");
> +		return;
> +	}
> +	mutex_unlock(&pdr->lock);
> +
> +	mutex_lock(&pdr->list_lock);
> +	list_for_each_entry(pds, &pdr->lookups, node) {
> +		if (!pds->need_locator_lookup)
> +			continue;
> +
> +		pds->need_locator_lookup = false;
> +		mutex_unlock(&pdr->list_lock);
> +
> +		ret = pdr_locate_service(pdr, pds);
> +		if (ret < 0)
> +			goto exit;
> +
> +		/* Initialize notifier QMI handle */
> +		mutex_lock(&pdr->lock);
> +		if (!pdr->notifier_init_complete) {
> +			ret = qmi_handle_init(&pdr->notifier_hdl,
> +					      SERVREG_STATE_UPDATED_IND_MAX_LEN,
> +					      &pdr_notifier_ops,
> +					      qmi_indication_handler);
> +			if (ret < 0) {
> +				mutex_unlock(&pdr->lock);
> +				goto exit;
> +			}
> +			pdr->notifier_init_complete = true;
> +		}
> +		mutex_unlock(&pdr->lock);
> +
> +		ret = qmi_add_lookup(&pdr->notifier_hdl, pds->service, 1,
> +				     pds->instance);
> +		if (ret < 0)
> +			goto exit;
> +
> +		return;

If the caller calls pdr_add_lookup() multiple times in quick succession
wouldn't it be possile to get the worker scheduled with multiple entries
in &pdr->lookups with need_locator_lookup set?

If so I think it makes sense to break the content of this loop, and the
error handling under exit out into a separate function.

And even if this would not be the case, breaking this out in a separate
function would allow you to change the loop to:

	list_for_each_entry() {
		if (pdr->need_locator_lookup) {
			do_the_lookup();
			break;
		}
	}

Which I think is easier to reason about than the loop with a return at
the end.

> +	}
> +	mutex_unlock(&pdr->list_lock);
> +exit:
> +	if (ret < 0) {
> +		/* Notify lookup failed */
> +		mutex_lock(&pdr->list_lock);
> +		list_del(&pds->node);
> +		mutex_unlock(&pdr->list_lock);
> +
> +		if (ret == -ENXIO)
> +			pds->state = SERVREG_LOCATOR_UNKNOWN_SERVICE;
> +		else
> +			pds->state = SERVREG_LOCATOR_ERR;
> +
> +		pr_err("PDR: service lookup for %s failed: %d\n",
> +		       pds->service_name, ret);
> +
> +		mutex_lock(&pdr->status_lock);
> +		pdr->status(pds->state, pds->service_path, pdr->priv);
> +		mutex_unlock(&pdr->status_lock);
> +		kfree(pds);
> +	}
> +}
[..]
> +struct pdr_handle *pdr_handle_alloc(void (*status)(int state,
> +						   char *service_path,
> +						   void *priv), void *priv)
> +{
> +	struct pdr_handle *pdr;
> +	int ret;
> +
> +	if (!status)
> +		return ERR_PTR(-EINVAL);
> +
> +	pdr = kzalloc(sizeof(*pdr), GFP_KERNEL);
> +	if (!pdr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pdr->status = *status;

Please omit the * here.

Regards,
Bjorn
