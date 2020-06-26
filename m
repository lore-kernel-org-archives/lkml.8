Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B9BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F21020775
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1odrzjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgFZIYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgFZIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:24:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DEFC08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:24:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so8588722wrq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R7Evw+hb459XiYsGH+Vi+eNq0D7kmPSCBdf5k4rfVcY=;
        b=q1odrzjyZY1tNyKxp9JyPIk0Pt0zB5Bg+tu8Z+X4nhJvMytgJkjWs1CMXFf0VGk0kB
         JyIvaALMurHhsXifgMI4kN4w3DXEB8ewsGBtx1qX7dPG1LVX0uTl2X2uZj+BzxRjAD9g
         ovA6GpYEIy/zHYsXDzTjEhlnWDggFXNQlRNEQ2K90eLTvrD2IrjIAgv27VwbgRWUBUFu
         wNWIHn0bOcGZDJ+gPbCUHFJEFdxU5epgCFeKxA93JznCr9F6Ua9JuRGJZzjeSlb5h45k
         KIKtSR1WyjM0qmus6ErfDwfIryPra3xxPaEvrYf+blS55f58lhul/jeduGK1wz8huj6t
         zdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7Evw+hb459XiYsGH+Vi+eNq0D7kmPSCBdf5k4rfVcY=;
        b=Y7+thcZzJE69OH3AkETLnPfo6l56MNRPVLgE2swtIxXNB9+x5zJ96xlt1NXvWXj3eS
         ZwtHkdk23BdY4f4ZWPMFxMHd7lpFn5f/UZuZ9VSqw97TK9GXRlhMp3T20gbIPmWQfnOz
         A2JPrszbunrMaSWj4OW8SC6XetymUv8aze4vQLGdtVGfuZSA1GFikQu1iv4vNf8/5NjS
         myb7kd80fWsRzjdbkZSwO9tZsfFKf7iSvQ5CF5lzwfYh/FBPfHU7aRnvNYFTcb9Qk4/2
         GJzFC889u4W45x2CEEZfUtlfm21jrETdhvJ3DzggkzUt3IN3Zn4TVMlDnaLc7jh/gA1E
         EmfQ==
X-Gm-Message-State: AOAM533dv8af9vsvlP5SwC4ikDtxJY8bvP3tQus3dOmeIfkg3Zj9O5I5
        u7GgIYFAI0+KRWvJn8sMJHiKZQ==
X-Google-Smtp-Source: ABdhPJzZmGQUKf+yqWXsRV27GJ6qG/7+zFrbPtoOSiYNAxz2SchfIUNtGbFpCYpfhP342BZNjnuRow==
X-Received: by 2002:adf:df03:: with SMTP id y3mr2332182wrl.376.1593159877423;
        Fri, 26 Jun 2020 01:24:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id x1sm10005457wrp.10.2020.06.26.01.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:24:36 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:24:33 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] cpufreq: Fix locking issues with governors
Message-ID: <20200626082433.GA284605@google.com>
References: <cover.1593143118.git.viresh.kumar@linaro.org>
 <f366ed3dd3dd111e42173b366fe4dd5a0e4647fd.1593143118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f366ed3dd3dd111e42173b366fe4dd5a0e4647fd.1593143118.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 Jun 2020 at 09:21:42 (+0530), Viresh Kumar wrote:
> The locking around governors handling isn't adequate currently. The list
> of governors should never be traversed without locking in place. Also we
> must make sure the governor isn't removed while it is still referenced
> by code.
> 
> Reported-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 59 ++++++++++++++++++++++++---------------
>  1 file changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0128de3603df..e798a1193bdf 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -621,6 +621,24 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
>  	return NULL;
>  }
>  
> +static struct cpufreq_governor *get_governor(const char *str_governor)
> +{
> +	struct cpufreq_governor *t;
> +
> +	mutex_lock(&cpufreq_governor_mutex);
> +	t = find_governor(str_governor);
> +	if (!t)
> +		goto unlock;
> +
> +	if (!try_module_get(t->owner))
> +		t = NULL;
> +
> +unlock:
> +	mutex_unlock(&cpufreq_governor_mutex);
> +
> +	return t;
> +}
> +
>  static unsigned int cpufreq_parse_policy(char *str_governor)
>  {
>  	if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN))
> @@ -640,28 +658,14 @@ static struct cpufreq_governor *cpufreq_parse_governor(char *str_governor)
>  {
>  	struct cpufreq_governor *t;
>  
> -	mutex_lock(&cpufreq_governor_mutex);
> -
> -	t = find_governor(str_governor);
> -	if (!t) {
> -		int ret;
> -
> -		mutex_unlock(&cpufreq_governor_mutex);
> -
> -		ret = request_module("cpufreq_%s", str_governor);
> -		if (ret)
> -			return NULL;
> -
> -		mutex_lock(&cpufreq_governor_mutex);
> +	t = get_governor(str_governor);
> +	if (t)
> +		return t;
>  
> -		t = find_governor(str_governor);
> -	}
> -	if (t && !try_module_get(t->owner))
> -		t = NULL;
> -
> -	mutex_unlock(&cpufreq_governor_mutex);
> +	if (request_module("cpufreq_%s", str_governor))
> +		return NULL;
>  
> -	return t;
> +	return get_governor(str_governor);
>  }
>  
>  /**
> @@ -815,12 +819,14 @@ static ssize_t show_scaling_available_governors(struct cpufreq_policy *policy,
>  		goto out;
>  	}
>  
> +	mutex_lock(&cpufreq_governor_mutex);
>  	for_each_governor(t) {
>  		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char))
>  		    - (CPUFREQ_NAME_LEN + 2)))
> -			goto out;
> +			break;
>  		i += scnprintf(&buf[i], CPUFREQ_NAME_PLEN, "%s ", t->name);
>  	}
> +	mutex_unlock(&cpufreq_governor_mutex);
>  out:
>  	i += sprintf(&buf[i], "\n");
>  	return i;
> @@ -1058,11 +1064,14 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  	struct cpufreq_governor *def_gov = cpufreq_default_governor();
>  	struct cpufreq_governor *gov = NULL;
>  	unsigned int pol = CPUFREQ_POLICY_UNKNOWN;
> +	bool put_governor = false;
> +	int ret;
>  
>  	if (has_target()) {
>  		/* Update policy governor to the one used before hotplug. */
> -		gov = find_governor(policy->last_governor);
> +		gov = get_governor(policy->last_governor);
>  		if (gov) {
> +			put_governor = true;
>  			pr_debug("Restoring governor %s for cpu %d\n",
>  				 policy->governor->name, policy->cpu);
>  		} else if (def_gov) {
> @@ -1089,7 +1098,11 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  			return -ENODATA;
>  	}
>  
> -	return cpufreq_set_policy(policy, gov, pol);
> +	ret = cpufreq_set_policy(policy, gov, pol);
> +	if (put_governor)
> +		module_put(gov->owner);

Nit: I think you could safely do

	if (gov)
		module_put(gov->owner);

and get rid of 'put_governor', given that try_module_get() and
module_put() are nops if owner is NULL (which is guaranteed for
the result of cpufreq_default_governor() as it is builtin).

But other than that:

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks!
