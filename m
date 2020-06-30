Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2FFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F538207F9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqjQx/HF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389987AbgF3RCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgF3RCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:02:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42985C061755;
        Tue, 30 Jun 2020 10:02:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so23475934ljh.7;
        Tue, 30 Jun 2020 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zm73/VCv6D7tyjxlDYUvUqi434b/awSj205uGGSiY5E=;
        b=tqjQx/HFMAKT91zIH/bwqIcsxDgnE+o7tj9C36qUiMT6LNlS/MRbarOXOhAjo05SoQ
         42fTsD0Bbk4bFkjSL/DeMJM1UVylpbSuBvlr1nF/qHCagwxzJ6dQLIUvvgqbJxLp18pv
         3LWb9GK2CNPoyF1sPNibc8ZYqqCmfOH0Xnk28lzC8Ct4OyESOg2brOSo2eMj2siUijDX
         Ivn+g/tGC1mkwx1GjiVqPpprQ6Up/09PXknZPXh0nlVUcLsCiMEYAzYS3Aj5GgaDi6Fp
         R0jkzp/RRyeUbxxpJmjJsJIiUR+11UuIhdigZDR4eYY8I+3d304tk+pC4kvx5942gepY
         dLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zm73/VCv6D7tyjxlDYUvUqi434b/awSj205uGGSiY5E=;
        b=OWee7zGU7J+sdUsJ4RNDErkYgz11GY+DqrnJmf1k7CMjxaxQ3C0dm27x9r4S+v1Ty5
         ijPyZhZU3OEaCh6NH8H0yaeI9C9eKogw9+3ljUWwB0UO01D9eP/nnUTcZM+f4U8yPpXw
         /HSCwFoOcQhF8RpC/gu7AGsAmQudcgHIXp8cNW3jp3tH4hDhtMg+LWj/8yN2l8vCuVNO
         Otwe2mEh0IHgqI5NtxUPEK7KrqraF5lScMCtoLSWqobmovHb+HXd7pBV+0kHU7Y67Zek
         7XW2YM8J2Rf+CW7V+uTk94OmbcEhpXYQxdKrzVuBISYBp67Dy8p8L0+XfvU0jGQWrc1I
         xH8A==
X-Gm-Message-State: AOAM532lIg/qKHxXpx4a9STzrza7fIeA0FK5Ys/6SYskHDOTt+pF6Hm+
        m+b3+ji09h1PbIGA9do15VkWfvqMhGI=
X-Google-Smtp-Source: ABdhPJySlQU/MvAcD940eAO4I0jczbnnGO6YWZ/sb/tciNiEsQmajGFLUIMqC2ALxjQA7vqNRzlD3A==
X-Received: by 2002:a2e:b8c2:: with SMTP id s2mr11668004ljp.368.1593536527151;
        Tue, 30 Jun 2020 10:02:07 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id d21sm587797ljo.85.2020.06.30.10.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 10:02:06 -0700 (PDT)
Subject: Re: [PATCH v8 1/7] of_graph: add of_graph_presents()
To:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200617222703.17080-1-digetx@gmail.com>
 <20200617222703.17080-2-digetx@gmail.com> <20200629231211.GA3142766@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1ef25775-1f37-25ce-f534-54cc995a5658@gmail.com>
Date:   Tue, 30 Jun 2020 20:02:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200629231211.GA3142766@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.06.2020 02:12, Rob Herring пишет:
> On Thu, Jun 18, 2020 at 01:26:57AM +0300, Dmitry Osipenko wrote:
>> In some case, like a DRM display code for example, it's useful to silently
>> check whether port node exists at all in a device-tree before proceeding
>> with parsing of the graph.
>>
>> This patch adds of_graph_presents() that returns true if given device-tree
>> node contains OF graph port.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/of/property.c    | 52 +++++++++++++++++++++++++++++++++-------
>>  include/linux/of_graph.h |  6 +++++
>>  2 files changed, 49 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/of/property.c b/drivers/of/property.c
>> index 1f2086f4e7ce..b84ed6a7cf50 100644
>> --- a/drivers/of/property.c
>> +++ b/drivers/of/property.c
>> @@ -29,6 +29,48 @@
>>  
>>  #include "of_private.h"
>>  
>> +/**
>> + * of_graph_get_first_local_port() - get first local port node
>> + * @node: pointer to a local endpoint device_node
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
>> + * of_graph_presents() - check graph's presence
>> + * @node: pointer to a device_node checked for the graph's presence
>> + *
>> + * Return: True if @node has a port or ports sub-node, false otherwise.
>> + */
>> +bool of_graph_presents(const struct device_node *node)
> 
> of_graph_is_present
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks!

I'll address the comment and then factor out this and the
drm_of_find_panel_or_bridge() changes into a separate series in v9,
since the Tegra DRM patches could be applied separately by Thierry.
