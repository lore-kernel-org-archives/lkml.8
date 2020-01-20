Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61498C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3386A20674
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3tmgLbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgATLLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:11:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54219 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgATLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:11:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so14046082wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 03:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NFqslHpRgb1cgGJbyvLG5KhYME4wr5wvzaaCw4RQTw4=;
        b=B3tmgLbjOcghFZeyKogDMxiOXy0h+J5JW45qdnSZtKrpseMK3WDhy8hoWdYuweirdU
         0CV2A94jMl5UZv0c1vwqWmUehWI75uORwvtMnB2QIjIATmdJEmEILPHbfJw6iThU9CTG
         MZh04Ruhele8ximcvmEWddBSQvdAMuvlHnN+dZJ889xkIVh2M+OQ0fvADoaqJy0BdBFF
         vlcG+Mn+NFCfkhZ4M7sIyVcL3095Y/iq+qH7ILjjZBkd/LJ51iW7oTsqCAx2iMekdk/J
         oCQo4O9VEmRGDhJlCUQgm/KFEs886wLMgPBRbk1VAc2j19v4B3s0pRomHSkdN2WgfuzR
         e4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NFqslHpRgb1cgGJbyvLG5KhYME4wr5wvzaaCw4RQTw4=;
        b=uDzKD6eAYUMKbxSGqWh5aHjnDG8OZY1HH9dNKnpfyJ/ZoqaEQOKcmbsv0Oqd6ZLbJo
         6qh/TF3iQ/gOPUocoFPwldUpLbX9CdiLOiy5fyUin66DnUjbgDGPmBnM1ZbgtImwDGPz
         1mIOmGpuJ+whyMBHS/oLuhZuyjwdSVp/wS3ggnQVNfEEXdhTIrwxXDdoIiJ0SLUmuVnP
         3bHny01+Qf0K4FwN4DuhcDCLgS/LG0CWKMWRA+4f5uztI4TriR1lQr9lylsEuaPq4FgJ
         oWVnk9odU0KpK1YmVJSD9EM4I3rdlz+UYA2JypM+/H8g5bbeyEZ54TWZxhcB5VSWNxoS
         W3HQ==
X-Gm-Message-State: APjAAAWLwVQhjmhHtRBa063n8gJAoCo3Yn02N7Osx6V+seVQ99z5EhZ8
        omCmDt/WezZI2GapXLl0CPvDDQ==
X-Google-Smtp-Source: APXvYqzMFhFWBcT7UY+37nRz5idtK8GuGZ0Wt8TGoyoaVqzPnkXenNKuXq5AFZAo5ab8npJUNi9NPw==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr18014003wmc.36.1579518703943;
        Mon, 20 Jan 2020 03:11:43 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id w13sm47420157wru.38.2020.01.20.03.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:11:43 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:11:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/36] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200120111159.GC15507@dell>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
 <20200113135623.56286-36-mika.westerberg@linux.intel.com>
 <20200116132108.GH325@dell>
 <20200116143730.GE2838@lahna.fi.intel.com>
 <20200117113202.GH15507@dell>
 <20200120092650.GI2665@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200120092650.GI2665@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Mark (the Regmap Maintainer) to the conversation.

On Mon, 20 Jan 2020, Mika Westerberg wrote:
> On Fri, Jan 17, 2020 at 11:32:02AM +0000, Lee Jones wrote:
> > [...]
> > 
> > > > Looks like Regmap could save you the trouble here.
> > > 
> > > Agreed.
> > 
> > Great.
> 
> I started to implement regmap for this driver but I run into some
> problems. The registers we read/write are all 64-bit and accessed trough
> readq/writeq accessors. However, the regmap API takes unsigned int:
> 
>   int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
>   int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
> 
> I'm not sure how we can take advantage of this API with the 64-bit
> registers. There are "raw" versions of the functions that take void
> pointer like:
> 
>  int regmap_raw_read(struct regmap *map, unsigned int reg,
>                      void *val, size_t val_len);
> 
> but looking at the implementation if the register gets cached it
> internally does reads in unsigned int sized chunks (if I understand it
> right).
> 
> Any ideas how this can be done?

Mark,

  Does Regmap support 64bit accesses?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
