Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E4EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FD020747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfZa8LOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGAGm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAGm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:42:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE90C061755;
        Tue, 30 Jun 2020 23:42:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so25594799ljv.5;
        Tue, 30 Jun 2020 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NyiY6LCbJOGlJn7q4DsF++6lUZNdDAhhofQm6gmCEgE=;
        b=gfZa8LOiRAlSm62lj9RtYmP3Tdvbt7VXnH8W1mmOJsHLME2QjEj0tNe6P6xB+RwGOJ
         C5/Db+Dx4Hfc7jZxX29rqo+oSYwRwh6b2dGTJ7NSDStqI9RJ3vpRnjhH+A3SDD/XaDub
         BRSuO9kWCq7XzO55zK+haH4wKH9hnETCrF94Nw1/3/iaBGklEPVTKyUEiFnXYwAEnxnN
         lynyoFsfBGIe97HaqJ+8LhZXWo39KoKPSwWgn1/phkpmJ05ufRo0BDY+eOsWQ+652myh
         Iul0Ney+yIjU+WQaxGnTROK8UXmiMuOLHnI33mKX4Ib5NC8e5H3kdr7pj+NDRruQfM9Y
         Rsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NyiY6LCbJOGlJn7q4DsF++6lUZNdDAhhofQm6gmCEgE=;
        b=lr4lDvYEERhSg1GQ3sVv+oRoXbN5aNae+FdOPkKAgHpxmRiWh1hgEFi1bNosNbKxVr
         yRly8zcFGCabgK2XWWWVnEyjWIcS93418fckY4gYdaktjrBGcNwO7bBz51v46/xOy5pD
         kqmFMwulfph2k+oHXPEOCcvspC0f4kgeAl2U919o3wjDoPzHnrH5woEg5oHwsCc3qzBC
         HP88dWfO3fwtirLQZY4ZZddm3q8jh/OtltKTLf7BXI4lW0siWluHuRAhSthR1EMAoJEM
         plpzxtBbuRHvBsS1GGrSsMAfzsI0YDLL9IcFV73XhhCGRWi4j3k+43Ej5wsR7B+98ncn
         L/fg==
X-Gm-Message-State: AOAM531I6CUk5bdCjkNc3rIbCdZn06lw/moNHuhZQoMF84C/4xEz2e77
        fcob4Z7dOsUjupF1mrDomE8kr2wOKGE=
X-Google-Smtp-Source: ABdhPJwnfvPM9Z0IHOBuk3PCfnWLRD3JRcFcWBcZcFIo3AdmsHbEgbmJo49UPIN0jd10KhzPKCpqcQ==
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr11424580ljl.256.1593585774925;
        Tue, 30 Jun 2020 23:42:54 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id u7sm1874014lfi.45.2020.06.30.23.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 23:42:53 -0700 (PDT)
Subject: Re: [PATCH v9 1/2] of_graph: add of_graph_is_present()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200701021617.12030-1-digetx@gmail.com>
 <20200701021617.12030-2-digetx@gmail.com>
 <20200701054543.GA5963@pendragon.ideasonboard.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c39beae6-34d4-84c3-07c0-e6639ab0b367@gmail.com>
Date:   Wed, 1 Jul 2020 09:42:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200701054543.GA5963@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.07.2020 08:45, Laurent Pinchart пишет:
> Hi Dmitry,
> 
> Thank you for the patch.
> 
> On Wed, Jul 01, 2020 at 05:16:16AM +0300, Dmitry Osipenko wrote:
>> In some case, like a DRM display code for example, it's useful to silently
>> check whether port node exists at all in a device-tree before proceeding
>> with parsing of the graph.
>>
>> This patch adds of_graph_is_present() which returns true if given
>> device-tree node contains OF graph port.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/of/property.c    | 52 +++++++++++++++++++++++++++++++++-------
>>  include/linux/of_graph.h |  6 +++++
>>  2 files changed, 49 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>> index 6a5760f0d6cd..e12b8b491837 100644
>> --- a/drivers/of/property.c
>> +++ b/drivers/of/property.c
>> @@ -29,6 +29,48 @@
>>  
>>  #include "of_private.h"
>>  
>> +/**
>> + * of_graph_get_first_local_port() - get first local port node
>> + * @node: pointer to a local endpoint device_node
> 
> It's not an endpoint.

Alright, somehow I was reading this as a "device_node that contains
endpoint (of the graph)". But after re-reading twice I can see that it's
not the case.

It should be a "pointer to device_node containing graph port", just like
the of_graph_get_remote_node() says it. Thank you :)

>> + *
>> + * Return: First local port node associated with local endpoint node linked
>> + *	   to @node. Use of_node_put() on it when done.
>> + */
>> +static struct device_node *
>> +of_graph_get_first_local_port(const struct device_node *node)
>> +{
>> +	struct device_node *ports, *port;
>> +
>> +	ports = of_get_child_by_name(node, "ports");
>> +	if (ports)
>> +		node = ports;
>> +
>> +	port = of_get_child_by_name(node, "port");
>> +	of_node_put(ports);
>> +
>> +	return port;
>> +}
>> +
>> +/**
>> + * of_graph_is_present() - check graph's presence
>> + * @node: pointer to a device_node checked for the graph's presence
>> + *
>> + * Return: True if @node has a port or ports sub-node, false otherwise.
>> + */
>> +bool of_graph_is_present(const struct device_node *node)
>> +{
>> +	struct device_node *local;
>> +
>> +	local = of_graph_get_first_local_port(node);
>> +	if (!local)
>> +		return false;
>> +
>> +	of_node_put(local);
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(of_graph_is_present);
>> +
>>  /**
>>   * of_property_count_elems_of_size - Count the number of elements in a property
>>   *
>> @@ -608,15 +650,7 @@ struct device_node *of_graph_get_next_endpoint(const struct device_node *parent,
>>  	 * parent port node.
>>  	 */
>>  	if (!prev) {
>> -		struct device_node *node;
>> -
>> -		node = of_get_child_by_name(parent, "ports");
>> -		if (node)
>> -			parent = node;
>> -
>> -		port = of_get_child_by_name(parent, "port");
>> -		of_node_put(node);
>> -
>> +		port = of_graph_get_first_local_port(parent);
> 
> I think this introduces a bug below in the function, where parent is
> used and is expected to point to the ports node if available. I'd leave
> this part of the change out, and inline +of_graph_get_first_local_port()
> in of_graph_is_present().

Good catch! I'll correct this.

Thank you for the review :)
