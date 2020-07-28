Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65777C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFE720759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595916582;
	bh=48t/tviNNRIg+EeS65tBn4H9+hR873biIv/oqCwU538=;
	h=Subject:From:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=rpeuDetWK7Jk3/Uoht3YnHV83Ter9xjqQcyYDkLeEnnKadnpnwaOxvAQedkoxNR1c
	 8OPmU/+wARM5F2mTpCEPyVG2W++muyUabqU0yQKJl/An3h2aFFPCpWSE6CIt93Ej8A
	 Gn4p9/qWHjrPHfXimYO7bgpCCGgRxrOA+ZQYwlgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgG1GJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:09:41 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:45232 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgG1GJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:09:40 -0400
Received: by mail-ej1-f66.google.com with SMTP id g7so11155856ejw.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ppP5UfQphCez2tdWV8+rtk+knr2xftIobaRmhJBQS/4=;
        b=C42XtBmGmnihMnE1xnnUHoyBdBct/7WO0EB1dxrx2814S4USoys/JLsgDkrPhh7uUd
         S+/oNzXBJe7tXC+Pg5lAPXA9Zk+VAwSqcgFGtoFEk9BZ+TRT04TOzNBg8QifAo2axUjf
         ZBlI81DPZzBz7K/Dlzg9jAvtDFuXQ/AAMBuGlwgD6+SwwDf6RN4HATC/iIe51R/eks2T
         HyZRrhoxcZyYTwKTu65bXA3hRTiHi5yNU3P8Y9lZOyO/SOMc9uHtm1TlNGNoxxf+g/OP
         f4NcnFEMJogeRcQRdzEnF04cA1/qvpfPxAN/tlu3P42aFy3cVMq94cTsniYTB2jLpI5d
         XZYQ==
X-Gm-Message-State: AOAM533mlX4hsiwH0LgmcwgnK3FF2q1ZCfYqJfAEngEUM4c7CEBrZ1oM
        fbaGaDXNcPLihhWMEYQZIMfgO7qA
X-Google-Smtp-Source: ABdhPJyX3klw9O6n49WLiLsfOC2u93YdBMc6bx2bsI+z7nQfj2YPZF9gjx55zyt9vobahCkPvnpSVw==
X-Received: by 2002:a17:906:3a8c:: with SMTP id y12mr23604986ejd.251.1595916577919;
        Mon, 27 Jul 2020 23:09:37 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id i14sm5780334edr.15.2020.07.27.23.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 23:09:37 -0700 (PDT)
Subject: Re: [PATCH] tty/synclink: remove leftover bits of non-PCI card
 support
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20200727130501.31005-1-hch@lst.de>
 <8a015ca4-e837-8fa5-684c-46fca8104ea5@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b286c9f4-f501-96a8-8e2d-52f46b53ab1a@kernel.org>
Date:   Tue, 28 Jul 2020 08:09:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8a015ca4-e837-8fa5-684c-46fca8104ea5@kernel.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28. 07. 20, 8:05, Jiri Slaby wrote:
> On 27. 07. 20, 15:05, Christoph Hellwig wrote:
>> Since commit 1355cba9c3ba ("tty/synclink: remove ISA support"), the
>> synlink driver only supports PCI card.  Remove any leftover dead code
>> to support other cards.
> 
> So now you can remove also the defines and bus_type completely:
> $ git grep -E 'MGSL_BUS_TYPE_(E?ISA|PCI)'
> drivers/tty/synclink_gt.c:              info->bus_type = MGSL_BUS_TYPE_PCI;
> drivers/tty/synclinkmp.c:               info->bus_type = MGSL_BUS_TYPE_PCI;
> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_ISA 1
> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_EISA        2
> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_PCI 5
> 
> $ git grep -w bus_type drivers/tty/synclink*
> drivers/tty/synclink_gt.c:      unsigned int bus_type;
> drivers/tty/synclink_gt.c:              info->bus_type = MGSL_BUS_TYPE_PCI;
> drivers/tty/synclinkmp.c:       unsigned int bus_type;
> /* expansion bus type (ISA,EISA,PCI) */
> drivers/tty/synclinkmp.c:               info->bus_type = MGSL_BUS_TYPE_PCI;

And also MAX_ISA_DEVICES and MAX_PCI_DEVICES are (transitively) unused.

-- 
js
