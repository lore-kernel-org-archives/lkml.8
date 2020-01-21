Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE3FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486A024653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHKF+M55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgAUL1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:27:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54310 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728741AbgAUL1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579606042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wLiGpMD42LOuU4kjzIpcVPiYqHbfTqMgURbNbtZMwA=;
        b=iHKF+M55zZdIE3IK9lByl1uM2VYEsEQWETRieAU6Ga2etWtYqVN+FYFYubO34B7PSGgivb
        EA/vOV+W1tnXUt0BenQRikZo2XFAfEA3vOSOSy7cHojXgKEx4MsvaFc0DoIGARsAZjsaEM
        6gSxcOUJ8BWx98tw4O4I3zLkWc2dkW4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-swv82KA8Mma6n3l8sW8OZg-1; Tue, 21 Jan 2020 06:27:21 -0500
X-MC-Unique: swv82KA8Mma6n3l8sW8OZg-1
Received: by mail-wr1-f72.google.com with SMTP id j4so1177750wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wLiGpMD42LOuU4kjzIpcVPiYqHbfTqMgURbNbtZMwA=;
        b=irQf/AN+IkObLiiSZRPWsa66d117qSIfzXymNwAUanhbpB+dVMqXVYWRMhSErvEEML
         Urjms2zYUHo1xGfzdjbdNLRprTKPtGtlSVFw/dFkrt7W0Tv8b2/hgT5DZRkfDbdWbezo
         yyy1wntwKfE5FM/kTU7y8h6D0v3jcY2jD+LvivYlGENJQnGF5GvbV1mYHdjExPhf7J3C
         Pxway0MZ2BdUkBy5CfNeKOWaM9W8qQRkderqezNVwoUI4XWb+p+1baJjw4o8hLhttBRp
         wh1y9ERDss8arqlfKfRu7PbzSJHq2QZ7tql/ZTOC2cxf1adN+5Ff3vY9865sA4knmt/+
         ozTg==
X-Gm-Message-State: APjAAAU0ZMZWt38EMmyaScq9PiA6PAguFkUekixE3+ehyyj30jB0H71/
        8KuCKj69bnlkqYTDZvPf46cYJtU6B2Ra54BvupjuY+JvmZHZb+W/7sAi88Cu03TPKia3lPlgr8J
        GdIAj9VOnXG5YaZbGZOck02xh
X-Received: by 2002:a5d:620b:: with SMTP id y11mr4699931wru.230.1579606039769;
        Tue, 21 Jan 2020 03:27:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzYu8JVEWTNn9Ir2TT0p2JoqpSNxpMZYoGI1bRoT37e/sljDk8LeKuy40yzk+swjn3q2vw3A==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr4699903wru.230.1579606039565;
        Tue, 21 Jan 2020 03:27:19 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id p15sm3329320wma.40.2020.01.21.03.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 03:27:19 -0800 (PST)
Subject: Re: [POC 03/23] livepatch: Better checks of struct klp_object
 definition
To:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200117150323.21801-1-pmladek@suse.com>
 <20200117150323.21801-4-pmladek@suse.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <a5327513-a208-a3c1-cbff-5e978a21b230@redhat.com>
Date:   Tue, 21 Jan 2020 11:27:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117150323.21801-4-pmladek@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 1/17/20 3:03 PM, Petr Mladek wrote:
> The number of user defined fields increased in struct klp_object after
> spliting per-object livepatches. It was sometimes unclear why exactly
> the module could not get loded when returned -EINVAL.
> 
> Add more checks for the split modules and write useful error
> messages on particular errors.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>   kernel/livepatch/core.c | 91 ++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 82 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index bb62c5407b75..ec7ffc7db3a7 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -756,9 +756,6 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
>   	int ret;
>   	const char *name;
>   
> -	if (klp_is_module(obj) && strlen(obj->name) >= MODULE_NAME_LEN)
> -		return -EINVAL;
> -
>   	obj->patched = false;
>   
>   	name = obj->name ? obj->name : "vmlinux";
> @@ -851,8 +848,86 @@ static int klp_init_patch(struct klp_patch *patch)
>   	return 0;
>   }
>   
> +static int klp_check_module_name(struct klp_object *obj, bool is_module)
> +{
> +	char mod_name[MODULE_NAME_LEN];
> +	const char *expected_name;
> +
> +	if (is_module) {
> +		snprintf(mod_name, sizeof(mod_name), "%s__%s",
> +			 obj->patch_name, obj->name);
> +		expected_name = mod_name;
> +	} else {
> +		expected_name = obj->patch_name;
> +	}
> +
> +	if (strcmp(expected_name, obj->mod->name)) {

I'm not sure I understand the point of enforcing this.

> +		pr_err("The module name %s does not match with obj->patch_name and obj->name. The expected name is: %s\n",
> +		       obj->mod->name, expected_name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int klp_check_object(struct klp_object *obj, bool is_module)
> +{
> +
> +	if (!obj->mod)
> +		return -EINVAL;
> +
> +	if (!is_livepatch_module(obj->mod)) {
> +		pr_err("module %s is not marked as a livepatch module\n",
> +		       obj->mod->name);
> +		return -EINVAL;
> +	}
> +
> +	if (!obj->patch_name) {
> +		pr_err("module %s does not have set obj->patch_name\n",
> +		       obj->mod->name);
> +		return -EINVAL;
> +	}
> +
> +	if (strlen(obj->patch_name) >= MODULE_NAME_LEN) {
> +		pr_err("module %s has too long obj->patch_name\n",
> +		       obj->mod->name);
> +		return -EINVAL;
> +	}
> +
> +	if (is_module) {
> +		if (!obj->name) {
> +			pr_err("module %s does not have set obj->name\n",
> +			       obj->mod->name);
> +			return -EINVAL;
> +		}
> +		if (strlen(obj->name) >= MODULE_NAME_LEN) {
> +			pr_err("module %s has too long obj->name\n",
> +			       obj->mod->name);
> +			return -EINVAL;
> +		}
> +	} else if (obj->name) {
> +		pr_err("module %s for vmlinux must not have set obj->name\n",
> +		       obj->mod->name);
> +		return -EINVAL;
> +	}
> +
> +	if (!obj->funcs) {
> +		pr_err("module %s does not have set obj->funcs\n",
> +		       obj->mod->name);
> +		return -EINVAL;
> +	}
> +
> +	return klp_check_module_name(obj, is_module);
> +}
> +
>   int klp_add_object(struct klp_object *obj)
>   {
> +	int ret;
> +
> +	ret = klp_check_object(obj, true);
> +	if (ret)
> +		return ret;
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(klp_add_object);
> @@ -958,14 +1033,12 @@ int klp_enable_patch(struct klp_patch *patch)
>   {
>   	int ret;
>   
> -	if (!patch || !patch->obj || !patch->obj->mod)
> +	if (!patch || !patch->obj)
>   		return -EINVAL;
>   
> -	if (!is_livepatch_module(patch->obj->mod)) {
> -		pr_err("module %s is not marked as a livepatch module\n",
> -		       patch->obj->patch_name);
> -		return -EINVAL;
> -	}
> +	ret = klp_check_object(patch->obj, false);
> +	if (ret)
> +		return ret;
>   
>   	if (!klp_initialized())
>   		return -ENODEV;
> 

Otherwise this looks good to me.

Cheers,

-- 
Julien Thierry

