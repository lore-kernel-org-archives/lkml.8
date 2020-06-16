Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DDFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC9A207C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAGImOj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgFPN4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgFPN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:56:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFA0C061573;
        Tue, 16 Jun 2020 06:56:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i3so19114624ljg.3;
        Tue, 16 Jun 2020 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PS/HoxcWaI8mWZ7gB9+dY98FWzRMtZgjXEzoehTh0Ew=;
        b=pAGImOj5/FyFG7cuoImMCNenbaRAmkeTotTDDzfPVZVbJM1K88K4JP6jm6dvadYcZy
         mPZC5kmnXbfscwKku7+Z/gM8b+ZSJgtl6d5voJZ0Po5uBt7VtwYQT48DoFwslLPdj+YH
         4JDzN8UsAam8lv/hY4H3SxlNVNpDUPPgtwxAVnwub6sRM1AFM5csEXv/pxUY64fgUerI
         f7hxolJj/ulFB9UCFpSVWlOtCyUFTNkAL+4rRN99AmoaF0Mt9LdK2Uw/u1drRDmLQ2rF
         rpMrSnktgUkzbFMa5/pB95loMH7fVddBJvQX5t3myVpCdi/GPT89SsHtTWFylKuqIoUM
         ff2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PS/HoxcWaI8mWZ7gB9+dY98FWzRMtZgjXEzoehTh0Ew=;
        b=XIaL1i2RoI7uSNcaS3RZpoLsGp/22yFDW/ug/Gv5EESHz4LSDjo4xvsbswnwCvTBZo
         qeDIYs+an04uKa3uIZ2wIzmfksm4LRTPMh2aAhjNTi4y1C/Mwh4vR3T2Vwmp3eQnApsw
         KVBc15GHRzNexexU73XK5QHOJvhXUJHpizkE6nkeIZRqhEuvB9bEcBoz5NuKoxRIQged
         Dntc3b6ZL6mdkmHKbMIOhqChHSwzlkF+Mn3nQGZWnGhrubOvh90MJ4hpyIE1uoh6GYGT
         VwlMSIRzFRNgAPLe0xc5m20XI+gHyR4kqoCap/A02hVNURFtyqKoOjrzW8ADvtD/V7mD
         cttA==
X-Gm-Message-State: AOAM5300Y6n13YJEqzCfOuOHxabFVJ7ohl7/wup3RrSTEpZRXR/E+iDn
        IYoy5HFwb9nwlJRy579ZwJKIqfap
X-Google-Smtp-Source: ABdhPJwzAbeBz96CnSD3eXpvoUY0onr46lm/vCHg1gRZHDpRKM99xRKWswjoFbC3ypLhP+eFpq26lA==
X-Received: by 2002:a2e:8601:: with SMTP id a1mr1404322lji.255.1592315803565;
        Tue, 16 Jun 2020 06:56:43 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id 80sm4401198ljf.85.2020.06.16.06.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 06:56:42 -0700 (PDT)
Subject: Re: [PATCH v7 1/6] of_graph: add of_graph_get_local_port()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200614172234.8856-1-digetx@gmail.com>
 <20200614172234.8856-2-digetx@gmail.com>
 <20200616012111.GE1629@pendragon.ideasonboard.com>
 <20200616012513.GF1629@pendragon.ideasonboard.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8b7c6395-edd8-cecd-7004-e9f3f22d61f2@gmail.com>
Date:   Tue, 16 Jun 2020 16:56:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200616012513.GF1629@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2020 04:25, Laurent Pinchart пишет:
> On Tue, Jun 16, 2020 at 04:21:12AM +0300, Laurent Pinchart wrote:
>> Hi Dmitry,
>>
>> Thank you for the patch.
>>
>> On Sun, Jun 14, 2020 at 08:22:29PM +0300, Dmitry Osipenko wrote:
>>> In some case, like a DRM display code for example, it's useful to silently
>>> check whether port node exists at all in a device-tree before proceeding
>>> with parsing the graph.
>>>
>>> This patch adds of_graph_get_local_port() which returns pointer to a local
>>> port node, or NULL if graph isn't specified in a device-tree for a given
>>> device node.
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/of/property.c    | 32 +++++++++++++++++++++++---------
>>>  include/linux/of_graph.h |  7 +++++++
>>>  2 files changed, 30 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>>> index 1f2086f4e7ce..05c5f619b8bb 100644
>>> --- a/drivers/of/property.c
>>> +++ b/drivers/of/property.c
>>> @@ -608,15 +608,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>>>  	 * parent port node.
>>>  	 */
>>>  	if (!prev) {
>>> -		struct device_node *node;
>>> -
>>> -		node = of_get_child_by_name(parent, "ports");
>>> -		if (node)
>>> -			parent = node;
>>> -
>>> -		port = of_get_child_by_name(parent, "port");
>>> -		of_node_put(node);
>>> -
>>> +		port = of_graph_get_local_port(parent);
>>>  		if (!port) {
>>>  			pr_err("graph: no port node found in %pOF\n", parent);
>>>  			return NULL;
>>> @@ -765,6 +757,28 @@ struct device_node *of_graph_get_remote_port(const struct device_node *node)
>>>  }
>>>  EXPORT_SYMBOL(of_graph_get_remote_port);
>>>  
>>> +/**
>>> + * of_graph_get_local_port() - get local port node
>>> + * @node: pointer to a local endpoint device_node
>>> + *
>>> + * Return: First local port node associated with local endpoint node linked
>>> + *	   to @node. Use of_node_put() on it when done.
>>> + */
>>> +struct device_node *of_graph_get_local_port(const struct device_node *node)
> 
> I forgot to mention that, given that there could be multiple 'port'
> nodes, this function would be better named
> of_graph_get_first_local_port(). 'first' here would refer to the nodes
> order in the device tree, which I believe may not match the port number.
> For instance, in the following case
> 
> 	ports {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		port@1 {
> 			reg = <1>;
> 		};
> 		port@0 {
> 			reg = <0>;
> 		};
> 	};
> 
> the function would I believe return port@1. It may be a good idea to
> explain this in the documentation.

Hello Laurent,

It's correct that the port@1 will be returned in yours example.

I'll improve the doc and the function's name in the next revision, thank
you for the suggestions!

> Depending on how you use this
> function, if your only use case is to test for the presence of port
> nodes, it may be best to return a bool and name it of_graph_has_port()
> or something similar.
> 
>>> +{
>>> +	struct device_node *ports, *port;
>>> +
>>> +	ports = of_get_child_by_name(node, "ports");
>>> +	if (ports)
>>> +		node = ports;
>>> +
>>> +	port = of_get_child_by_name(node, "port");
>>> +	of_node_put(ports);
>>> +
>>> +	return port;
>>
>> The implementation doesn't seem to match the documentation. If node is a
>> pointer to an endpoint, it should not have any ports child.

Right, I'll reword the doc in v8. This function doesn't differentiate
between start / end points. It's up to a user of this function to check
whether node is endpoint or something else if needed.

Thank you very much for the comments!
