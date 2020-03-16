Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32223C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081DD20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVXJUCxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbgCPWJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:09:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42599 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPWJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:09:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id t3so8628768plz.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B5SCW2mpwqfmklTei3IeO+x4lJGs0aSMZDQgwcWofPQ=;
        b=oVXJUCxuUtRI/jY4vIsIq5/aCvthVQhuW+fQge67kF7fyLZTLDLGe3kGCyHn5DDYdl
         6IBdZaaxCsODY+QT0VY9gWsHOTSSPW7l+MGn5xNXr85B7kT5QrxCfMgm5wQvcjfMOz6+
         O/vYNKhnRvHEoGxAcPLcrn0tSMxEsX+5q4ZC85EAE+n3WSr7OurXDXKbzQdndNrD4z+b
         1MIZOFANlv4CtDy6rMzZA4L5O545VKfaMnr6CSl4BJkXa1PX7e9VRLrqhKtvbzoGGMia
         bMuokD6q46KE7vVTk43WyjSn0W7N0MSKE6i9sPy8BtlnoP/XGkZo+pz6UE8Mip/W38p8
         rVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B5SCW2mpwqfmklTei3IeO+x4lJGs0aSMZDQgwcWofPQ=;
        b=ZMYYWqeevd0MLNnQp6DtIRpJ1UKmy91KdmVv+79U/GF3uoZq6wwlvYfTo7hCFwwOnT
         A77dhMsUWm3QCFgirrSQD+F8PHgkZuD+RScGAVtk0GWr7ydKnNq9AccTKoX3uFTNmPix
         bxAHhruOhhDpj+l/o0WLoNOEr/CgNYNetxwrV2YZQ4r4ELkjQZEmgTNkCLeJiV8vZJCc
         0RkMsfspxT0UzPChqhi6/PQjsnik/Cw/CLqH4MWi80E09MEbnsGycgND4M84k0P3Im9J
         cOVbBnCBn5VDfxuhsQNk2TQZW70VXIuYomxOeu+2lkvrZxkKDB9omiploCpJaHiMHCVr
         cOag==
X-Gm-Message-State: ANhLgQ1olLWkbfginpQKPOABZwrhvk1as6SsHMwtZHtAttz3bfM2fnQ7
        UE2lmN9rboQJuEDE85Yino3gHQ==
X-Google-Smtp-Source: ADFU+vsLXoJYCvXg5JukbIDAjlvi58zKDpDTMAntAZBEQZo6NTjd4Zk8DZY+t3cbSOG5GYO7mJEigA==
X-Received: by 2002:a17:902:8603:: with SMTP id f3mr1228175plo.235.1584396570907;
        Mon, 16 Mar 2020 15:09:30 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v123sm827164pfb.85.2020.03.16.15.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 15:09:30 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:09:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] soc: qcom: pdr: Avoid uninitialized use of found in
 pdr_indication_cb
Message-ID: <20200316220928.GA1135@builder>
References: <20200316204855.15611-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316204855.15611-1-natechancellor@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 Mar 13:48 PDT 2020, Nathan Chancellor wrote:

> Clang warns:
> 
> ../drivers/soc/qcom/pdr_interface.c:316:2: warning: variable 'found' is
> used uninitialized whenever 'for' loop exits because its condition is
> false [-Wsometimes-uninitialized]
>         list_for_each_entry(pds, &pdr->lookups, node) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../include/linux/list.h:624:7: note: expanded from macro
> 'list_for_each_entry'
>              &pos->member != (head);
>              ^~~~~~~~~~~~~~~~~~~~~~
> ../drivers/soc/qcom/pdr_interface.c:325:7: note: uninitialized use
> occurs here
>         if (!found)
>              ^~~~~
> ../drivers/soc/qcom/pdr_interface.c:316:2: note: remove the condition if
> it is always true
>         list_for_each_entry(pds, &pdr->lookups, node) {
>         ^
> ../include/linux/list.h:624:7: note: expanded from macro
> 'list_for_each_entry'
>              &pos->member != (head);
>              ^
> ../drivers/soc/qcom/pdr_interface.c:309:12: note: initialize the
> variable 'found' to silence this warning
>         bool found;
>                   ^
>                    = 0
> 1 warning generated.
> 
> Initialize found to false to fix this warning.
> 
> Fixes: fbe639b44a82 ("soc: qcom: Introduce Protection Domain Restart helpers")
> Link: https://github.com/ClangBuiltLinux/linux/issues/933
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks Nathan, applied with Nick's ack.

Regards,
Bjorn

> ---
>  drivers/soc/qcom/pdr_interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
> index 7ee088b9cc7c..17ad3b8698e1 100644
> --- a/drivers/soc/qcom/pdr_interface.c
> +++ b/drivers/soc/qcom/pdr_interface.c
> @@ -306,7 +306,7 @@ static void pdr_indication_cb(struct qmi_handle *qmi,
>  	const struct servreg_state_updated_ind *ind_msg = data;
>  	struct pdr_list_node *ind;
>  	struct pdr_service *pds;
> -	bool found;
> +	bool found = false;
>  
>  	if (!ind_msg || !ind_msg->service_path[0] ||
>  	    strlen(ind_msg->service_path) > SERVREG_NAME_LENGTH)
> -- 
> 2.26.0.rc1
> 
