Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C39C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C757206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWs4R9Zw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCHVc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:32:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41745 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgCHVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 17:32:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so3157409plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f9/0ieWDmPVyDB4Z2hwh7wW0M3gQcpkCSJj06NxF8yI=;
        b=DWs4R9Zw4bFp0twDiTO0rAcVPqJ9MeuA6SGCskUyImzV+noQgWAPHlXfv8l4WdYjv8
         oN8GxHJ+AM4XJnT01GzSQvh00zsraaW7uLJAzv0mOe2BKrv3BgnMWhJ52fAGVpCZBjOK
         xDmHmcyHCBkVIltQazD5tHWp0D/jCKFzJkSl0hhYE08+m2ZWmtMcC1mh33AKEzlvdQuc
         JbSDUtlO4EOO60PiDRWOcknpIX5m7V2FVmL/77X0x6MZbwSuyFjUDdim0IQJHHUc/ylb
         KutyjacJdKnmGxvcVNEFrA+BpQz/JH1XFjfZFiA6N2jEpUtrajD0968rCzAVaZHU8XL7
         RWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9/0ieWDmPVyDB4Z2hwh7wW0M3gQcpkCSJj06NxF8yI=;
        b=c8A6xzzzKxW6Di7M4NyPXUK0xDSiTmo89yRtSa/oYn76DpO3CcV2q0WektI4C0qLRB
         Ofx8yI/2GIegah+3lVD8IfppTb0mXYogSOryDTAcNp5OzsZepsLHOjyLRmRRaofTXDAI
         vd8ptASkdZkDD2TLrL9gZ4SiEVb5jLS50aINBmsxDVr/YQ8GW7fgL6sREshM6HBg2Z68
         El8LvSfRGRRCve+hnJ2kUNGnLqnyPPwdEoT0DvbqXcnSuPJTU3WUBXC8PXrFqgeakEyf
         eo145VbXc1eqZCjBw53otFd/jXUHnNKC6+Y1ibRTcLE2d0Yx+B96T+g07cZPGEgWhHaI
         zPSQ==
X-Gm-Message-State: ANhLgQ3+D2r7OiwL7V+Cw2rvOp2Gyz5j1BlgDBtfI52QvrrpNJyqyu8E
        JUVTliwDZhD8N+0M1TvZQuVsGA==
X-Google-Smtp-Source: ADFU+vtvtCHb8/W34pLlH4mKGucPBSrpWEisS/mQ6Fgz+/N0TWyLL1lRf/YSSKJWR8kAdKfYCuTdow==
X-Received: by 2002:a17:902:5996:: with SMTP id p22mr13118027pli.190.1583703143741;
        Sun, 08 Mar 2020 14:32:23 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g20sm15977866pjv.20.2020.03.08.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 14:32:22 -0700 (PDT)
Date:   Sun, 8 Mar 2020 14:32:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     srinivas.kandagatla@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tsoni@codeaurora.org, vnkgutta@codeaurora.org
Subject: Re: [PATCH v6 1/3] soc: qcom: Introduce Protection Domain Restart
 helpers
Message-ID: <20200308213220.GK1094083@builder>
References: <20200304200911.15415-1-sibis@codeaurora.org>
 <20200304200911.15415-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304200911.15415-2-sibis@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Mar 12:09 PST 2020, Sibi Sankar wrote:
> diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
[..]
> +static int pdr_locate_service(struct pdr_handle *pdr, struct pdr_service *pds)
> +{
> +	struct servreg_get_domain_list_resp *resp;
> +	struct servreg_get_domain_list_req req;
> +	struct servreg_location_entry *entry;
> +	int domains_read = 0;
> +	int ret, i;
> +
> +	resp = kzalloc(sizeof(*resp), GFP_KERNEL);
> +	if (!resp)
> +		return -ENOMEM;
> +
> +	/* Prepare req message */
> +	strcpy(req.service_name, pds->service_name);
> +	req.domain_offset_valid = true;
> +	req.domain_offset = 0;
> +
> +	do {
> +		req.domain_offset = domains_read;
> +		ret = pdr_get_domain_list(&req, resp, pdr);
> +		if (ret < 0)
> +			goto out;
> +
> +		for (i = domains_read; i < resp->domain_list_len; i++) {
> +			entry = &resp->domain_list[i];
> +
> +			if (strnlen(entry->name, sizeof(entry->name)) == sizeof(entry->name))
> +				continue;
> +
> +			if (!strcmp(entry->name, pds->service_path)) {
> +				pds->service_data_valid = entry->service_data_valid;
> +				pds->service_data = entry->service_data;
> +				pds->instance = entry->instance;
> +				goto out;
> +			}
> +		}
> +
> +		/* Update ret to indicate that the service is not yet found */
> +		ret = -ENXIO;
> +
> +		/* Always read total_domains from the response msg */
> +		if (resp->domain_list_len > resp->total_domains)
> +			resp->domain_list_len = resp->total_domains;
> +
> +		domains_read += resp->domain_list_len;
> +	} while (domains_read < resp->total_domains);
> +out:
> +	kfree(resp);
> +	return ret;
> +}
> +
> +static void pdr_notify_lookup_failure(struct pdr_handle *pdr,
> +				      struct pdr_service *pds,
> +				      int err)
> +{
> +	list_del(&pds->node);
> +
> +	if (err == -ENXIO)
> +		pds->state = SERVREG_LOCATOR_UNKNOWN_SERVICE;
> +	else
> +		pds->state = SERVREG_LOCATOR_ERR;
> +
> +	pr_err("PDR: service lookup for %s failed: %d\n",
> +	       pds->service_name, err);
> +
> +	mutex_lock(&pdr->status_lock);
> +	pdr->status(pds->state, pds->service_path, pdr->priv);
> +	mutex_unlock(&pdr->status_lock);
> +	kfree(pds);

So this implies that we didn't find the service and we will never find
it? How are the client drivers expected to react to above two states?

> +}
> +
> +static void pdr_locator_work(struct work_struct *work)
> +{
> +	struct pdr_handle *pdr = container_of(work, struct pdr_handle,
> +					      locator_work);
> +	struct pdr_service *pds, *tmp;
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
> +	list_for_each_entry_safe(pds, tmp, &pdr->lookups, node) {
> +		if (!pds->need_locator_lookup)
> +			continue;
> +
> +		pds->need_locator_lookup = false;
> +		ret = pdr_locate_service(pdr, pds);
> +		if (ret < 0)
> +			pdr_notify_lookup_failure(pdr, pds, ret);

If I read this correctly, pdr_locate_service() returning an error seems
to mean that pd->instance won't be filled out, as such I don't think you
want to proceed.

Further more, pdr_notify_lookup_failure() ends up freeing the pds, so
below lookup would be a use after free, not unlikely followed by a
double free of pds.

How about a "continue" here and only clear need_locator_lookup if both
of these checks pass?

> +
> +		ret = qmi_add_lookup(&pdr->notifier_hdl, pds->service, 1,
> +				     pds->instance);
> +		if (ret < 0)
> +			pdr_notify_lookup_failure(pdr, pds, ret);
> +	}
> +	mutex_unlock(&pdr->list_lock);
> +}

Apart from that I think the patches look good now.

Regards,
Bjorn
