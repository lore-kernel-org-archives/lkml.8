Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB89C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB3C208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADu0zGoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgFPOmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbgFPOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:42:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350FAC061573;
        Tue, 16 Jun 2020 07:42:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so23899565lji.2;
        Tue, 16 Jun 2020 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7P3LB8iTbLRgQbcq6lDOMzujkFPYmAYJeuZvysUa6f8=;
        b=ADu0zGoccAnnbS99Om04LkeJDNXA9DWDossI9TySgkmvs4J+DKTT+JIKZhXaNnLmzb
         WYkPFt34tOPuseJUbTM9ZtB0PVi2e8Lg5Vq+I+SmmjoIEWeoJ/ENydWUc+3MRck84qBS
         Mt47n2z23tQ7aa4Auo68bD0WRYVpc3d6gO9WJVuDK3/npnE7AjX2H6H+QXUq0uKZbQkS
         au8u0ny2N/inXli/Z62DboR5qtqj22jwvK4fsmPI4aw51bGA9i+PqxLh8yktJbNQeZ58
         hqSnFS8KIvknbjw6c2d6jiBFYnqKFnRjTgHBxEZrbSAPQ0v0nfaj/+i5M2JRPYzGM9ZR
         dMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7P3LB8iTbLRgQbcq6lDOMzujkFPYmAYJeuZvysUa6f8=;
        b=cHtLyN4zWZT+HQIpI+960kS6wX0iD4Rc7knH/TOy68gpz7ocoLl9ezXbq+g+wOomgY
         m0jN9905XK67NnLetX5EBe8A8u1ZXgKcmsHHykKxZbpLJF/l3qu4IB6NUlDMq/7xZwMk
         4PQlm0vMA7kT68jCRj4IFK0nXkE2Odolqv3VYKa/MCUQBi2GkvoIksz5FW8zHMzvRNBk
         5up348ZL/3oWwQO5fFeAYDCmx9D7XavryZ9F7VdE3R/nyYDuSmgkO5nhUDjR9dlX98/u
         JbfPMcNY5iL0q6xNpoNSXBVZ2MoDnJdliGIoMols+rEPPaUodKz7VHeYdeTssHFOXPxb
         w3HQ==
X-Gm-Message-State: AOAM533rDiB/sb+gX6irZEk7x9fEJDDDw4OjE0ECMXBGh9XKxD6ORGu0
        1dXJnA834tEokVS9Tpwi6MOiMpZs
X-Google-Smtp-Source: ABdhPJzHbxcWgrsUxt3jCoFrHkDiV/PhurwVcFvaIIZXLxdiCSoHFpT/VAaQTPgjgct7v0/18fPXbQ==
X-Received: by 2002:a2e:b892:: with SMTP id r18mr1720077ljp.319.1592318570363;
        Tue, 16 Jun 2020 07:42:50 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id z15sm4451503ljo.102.2020.06.16.07.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 07:42:49 -0700 (PDT)
Subject: Re: [PATCH v7 2/6] drm/of: Make drm_of_find_panel_or_bridge() to
 check graph's presence
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200614172234.8856-1-digetx@gmail.com>
 <20200614172234.8856-3-digetx@gmail.com>
 <20200616012652.GG1629@pendragon.ideasonboard.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4f0bb2e8-3522-4a3e-4ebd-32f9d5bc2da5@gmail.com>
Date:   Tue, 16 Jun 2020 17:42:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200616012652.GG1629@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2020 04:26, Laurent Pinchart пишет:
> Hi Dmitry,
> 
> Thank you for the patch.
> 
> On Sun, Jun 14, 2020 at 08:22:30PM +0300, Dmitry Osipenko wrote:
>> When graph isn't defined in a device-tree, the of_graph_get_remote_node()
>> prints a noisy error message, telling that port node is not found. This is
>> undesirable behaviour in our case because absence of a panel/bridge graph
>> is a valid case. Let's check presence of the local port in a device-tree
>> before proceeding with parsing the graph.
>>
>> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/drm_of.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
>> index b50b44e76279..e0652c38f357 100644
>> --- a/drivers/gpu/drm/drm_of.c
>> +++ b/drivers/gpu/drm/drm_of.c
>> @@ -239,13 +239,24 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
>>  				struct drm_bridge **bridge)
>>  {
>>  	int ret = -EPROBE_DEFER;
>> -	struct device_node *remote;
>> +	struct device_node *local, *remote;
>>  
>>  	if (!panel && !bridge)
>>  		return -EINVAL;
>>  	if (panel)
>>  		*panel = NULL;
>>  
>> +	/*
>> +	 * of_graph_get_remote_node() produces a noisy error message if port
>> +	 * node isn't found and the absence of the port is a legit case here,
>> +	 * so at first we silently check presence of the local port.
>> +	 */
>> +	local = of_graph_get_local_port(np);
>> +	if (!local)
>> +		return -ENODEV;
>> +
>> +	of_node_put(local);
>> +
> 
> The code looks fine, but you may want to take into account my proposal
> in 1/7 to instead create a of_graph_has_port() function. The could would
> be simpler here.
> 
>>  	remote = of_graph_get_remote_node(np, port, endpoint);
>>  	if (!remote)
>>  		return -ENODEV;
> 

I like yours proposals and will prepare v8 based on them, thanks!
