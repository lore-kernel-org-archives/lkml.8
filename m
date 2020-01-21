Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A062CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7265721569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJVy4Vqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgAUL7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:59:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35241 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbgAUL7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579607939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mIJRmUS3RoI/eRku0oSveKGJeOaZOoTBV3XTY86CXrI=;
        b=WJVy4Vqa1w7I4WL8oET5U0FvWnv3lJF6WAJ8P6Wyr4G3y/+CjIMOJtmbLX634y96bW+u5R
        j7fokqD1bYhHaVbCMV/G+eXAxDnGc6veExe+mXTO40Dwa2vWPSjJCH57KaolpLISPuLUQX
        f8SBDIegZ6KPVuH3t1xiwh29gSL2zN0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-Rarb8yzLMGmEhWxJ5_-tdw-1; Tue, 21 Jan 2020 06:58:56 -0500
X-MC-Unique: Rarb8yzLMGmEhWxJ5_-tdw-1
Received: by mail-wm1-f69.google.com with SMTP id g26so337233wmk.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mIJRmUS3RoI/eRku0oSveKGJeOaZOoTBV3XTY86CXrI=;
        b=bB7K8vgm6hCVvS7loIqjL3zK4A1zRBM81kBTA2PelIaRxocFuNg+0QoUlHPiW/7Dio
         jN+kmk3MJ4KVr6LRi7C6ZlhiwqaO6zcQQ9EorKdQ6vp3Drz7uZsU7Hi3Px6WqX7ltiAY
         RmcI1/LXN25s/Hq8ZFCjUC4MrizKFNGe2F+AWuQsd0tGcXcYeeEpzPUvdq/iLEpkEVDv
         QNT5ZMNDl93LSWOlSC6qVRthmt8d+ZkLbx82ed6rZSmQmX1FnIXTeBuZ5zyQwwTMvK6J
         0couFORZdnFYcJD8jKaZrj2NYwwp3wA20H6wZWPO1xKeeVYGF+qldjJPgZ5vxx1O/TYO
         EEXw==
X-Gm-Message-State: APjAAAXba6UoQFAet0ZDPzKRn9N5d2Wqebngw3YPk5uzQwwXq095Ano/
        RV96faNOA5lQkgDReDit8jrmVEMt2Ab+YImtZbzQwsDf/bQbfx+mfVgqoTBsOpeOQa+r4orvZUK
        5G3Ivly0ZD1Kf09hyglVsS1sB
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr4079718wme.151.1579607935021;
        Tue, 21 Jan 2020 03:58:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1OprcTDbiQO/QR6z0+OgYBrUc82Dc0O0g2xxJa107E1VFaHvFSIoh4166ZrRF0PqTnsAc4Q==
X-Received: by 2002:a1c:a9c6:: with SMTP id s189mr4079700wme.151.1579607934843;
        Tue, 21 Jan 2020 03:58:54 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id x11sm53508323wre.68.2020.01.21.03.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 03:58:54 -0800 (PST)
Subject: Re: [POC 05/23] livepatch: Initialize and free livepatch submodule
To:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200117150323.21801-1-pmladek@suse.com>
 <20200117150323.21801-6-pmladek@suse.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <0cc056a0-99c7-68d6-9f22-28c043254ab2@redhat.com>
Date:   Tue, 21 Jan 2020 11:58:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117150323.21801-6-pmladek@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 1/17/20 3:03 PM, Petr Mladek wrote:
> Another step when loading livepatches to livepatch modules is
> to initialize the structure, create sysfs entries, do livepatch
> specific relocations.
> 
> These operation can fail and the objects must be freed that case.
> The error message is taken from klp_module_coming() to match
> selftests.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>   kernel/livepatch/core.c | 34 +++++++++++++++++++++++++++-------
>   1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index e2c7dc6c2d5f..6c27b635e5a7 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -583,18 +583,23 @@ static void klp_free_object_loaded(struct klp_object *obj)
>   	}
>   }
>   
> +static void klp_free_object(struct klp_object *obj, bool nops_only)
> +{
> +	__klp_free_funcs(obj, nops_only);
> +
> +	if (nops_only && !obj->dynamic)
> +		return;
> +
> +	list_del(&obj->node);
> +	kobject_put(&obj->kobj);
> +}
> +
>   static void __klp_free_objects(struct klp_patch *patch, bool nops_only)
>   {
>   	struct klp_object *obj, *tmp_obj;
>   
>   	klp_for_each_object_safe(patch, obj, tmp_obj) {
> -		__klp_free_funcs(obj, nops_only);
> -
> -		if (nops_only && !obj->dynamic)
> -			continue;
> -
> -		list_del(&obj->node);
> -		kobject_put(&obj->kobj);
> +		klp_free_object(obj, nops_only);
>   	}
>   }
>   
> @@ -812,6 +817,8 @@ static int klp_init_object_early(struct klp_patch *patch,
>   	if (obj->dynamic || try_module_get(obj->mod))
>   		return 0;
>   
> +	/* patch stays when this function fails in klp_add_object() */
> +	list_del(&obj->node);
>   	return -ENODEV;
>   }
>   
> @@ -993,9 +1000,22 @@ int klp_add_object(struct klp_object *obj)
>   		goto err;
>   	}
>   
> +	ret = klp_init_object_early(patch, obj);

klp_init_object_early() can fail after adding obj to patch->obj_list. 
This wouldn't get cleaned up by the "err" path.

It probably would keep things simple to only add obj to patch->obj_list 
if early initialization is successful in patch 2 (ofc I'm talking about 
the actual patch of this patch series ;) ).

> +	if (ret)
> +		goto err;
> +
> +	ret = klp_init_object(patch, obj);
> +	if (ret) {
> +		pr_warn("failed to initialize patch '%s' for module '%s' (%d)\n",
> +			patch->obj->patch_name, obj->name, ret);
> +		goto err_free;
> +	}
> +
>   	mutex_unlock(&klp_mutex);
>   	return 0;
>   
> +err_free:
> +	klp_free_object(obj, false);
>   err:
>   	/*
>   	 * If a patch is unsuccessfully applied, return
> 

Cheers,

-- 
Julien Thierry

