Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A045EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7209722B48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkdNCMeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgCBVLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:11:25 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45480 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBVLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:11:25 -0500
Received: by mail-yw1-f68.google.com with SMTP id d206so1201211ywa.12;
        Mon, 02 Mar 2020 13:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F0HL80J7kuZM07v7wmBwvHZXsoxo7BhJdIKwu4WIppM=;
        b=lkdNCMeboBs8oFN+llu/al0AbK6PTFRrudi+Zr+2ofiInE7tXBRT/EHtAA4+bFxcrb
         RAB/RXIzJTsfXf71L8erOEAA8h3AipQHfyxX3cieSWmeSAiwXcb99KPtklLo+S5h2FaC
         KW/1QgeV/yVJ5ksChrcqqNIEIrPEpUALnJ3COEky0StpDQ3x0RXMwnP1ohWgW12TDsqi
         Lfu4Nk7y44F7IHbmURLRHG3Vd41fkdFiK8XlJL+npNOkKJIahJK7ReYVKnflH6R7j069
         afg2CU/ANZF0YCfo5Eb94sk8vcB6DpLOGdBnL67XrEFgRNvSnMgZBQ3sdtDDq4xPMOrA
         mVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F0HL80J7kuZM07v7wmBwvHZXsoxo7BhJdIKwu4WIppM=;
        b=XGgiNqk0/x+1Mw98RR6HvjffvQhaz0oMYs1yPc7w2DFbTdmZUkH+tmi1o/41Khkh98
         aSvLaPPWWw/2o8Utw0L1Uhj51fKJrwd4gPCHZt7FO48tiH3xfeaBH6ed9AwPRXX7fkJB
         Kr63jSMlGnPH7lRJ2mC18p/foBVwB+K6jmJxNGWlhjGNHWK9TVRBlJXZVUk8O/qIfbT7
         3W/3WTpfKD8k6lS6XwIQkGEerdjNSSVULBRjrP0fWNpb9k3Sm9PSyqGKzebqRYpnZQQy
         qcJm+sY15MNgXzDISoPETixQD/5ulS6plG8ZbTTLDAAyIJnzvQoHGbbjrc/33YAAgSdE
         kC1Q==
X-Gm-Message-State: ANhLgQ0C9slXkKbigNURPue0WWGWwrORMuu66ta7k6Rc+2jF7Fyvoua3
        Vg8/lX6Z4buHg3NmD1Z86xY=
X-Google-Smtp-Source: ADFU+vs2NqBS/EQddBerCQZNrrJAQcKWbH9EUWzhaj8PNH7Fk7KSRJiNDRkLfVIu3vZwkS1dixOitg==
X-Received: by 2002:a5b:452:: with SMTP id s18mr892773ybp.275.1583183483741;
        Mon, 02 Mar 2020 13:11:23 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id t128sm2130640ywe.56.2020.03.02.13.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 13:11:23 -0800 (PST)
Subject: Re: [PATCH v2 03/12] docs: dt: usage_model.rst: fix link for DT usage
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
 <a7e0a5597ace97503c8ff67cdab2351151c7f267.1583135507.git.mchehab+huawei@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7a4d92e5-a1e2-6bd2-9a40-dcdb52e80801@gmail.com>
Date:   Mon, 2 Mar 2020 15:11:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a7e0a5597ace97503c8ff67cdab2351151c7f267.1583135507.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 1:59 AM, Mauro Carvalho Chehab wrote:
> The devicetree.org doesn't host the Device_Tree_Usage page
> anymore. So, fix the link to point to a new address.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/usage-model.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
> index 326d7af10c5b..e1b42dc63f01 100644
> --- a/Documentation/devicetree/usage-model.rst
> +++ b/Documentation/devicetree/usage-model.rst
> @@ -12,7 +12,7 @@ This article describes how Linux uses the device tree.  An overview of
>  the device tree data format can be found on the device tree usage page
>  at devicetree.org\ [1]_.

s/devicetree.org/elinux.org/


>  
> -.. [1] http://devicetree.org/Device_Tree_Usage
> +.. [1] https://elinux.org/Device_Tree_Usage
>  
>  The "Open Firmware Device Tree", or simply Device Tree (DT), is a data
>  structure and language for describing hardware.  More specifically, it
> 

