Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6499C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9CC20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfDAZtWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgG3QFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbgG3QFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:05:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B83C061574;
        Thu, 30 Jul 2020 09:05:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so2671257pjb.2;
        Thu, 30 Jul 2020 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sjM57ha+vJYqRvVYXKRxv4JD7BARdJVnUhdosae9IdI=;
        b=bfDAZtWsOIlZK3dnXZ5P1/co/Kv/ZpIYJ+wKEwGPckd0MOH5O99cAH+t3Blg6ojxGM
         xRQprfxROCi7wWINWFrwyqzA4NyAQ9aZQui5D6GJ9kdINzX91e/wN7m06KWdfDcxKv3D
         WLrx/05kZSIoMYDaHcYLIbtvwuJ8OPn1PTSH8tzpGPz3A3v4M157hCoq+0v+7mBux0FE
         lZ161xKbUvcSVaIeiijcMXz+gSzgCrKC6oD1UDys1pvnOgnOt+shRgZNkHNhuDy8N6PV
         HUlvejPFI3IbfcysGB2oxEt8kxCgEN1SRsK3pJZ870vl2TAfvzBU8W5W5LzLQk2IY1dz
         QexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sjM57ha+vJYqRvVYXKRxv4JD7BARdJVnUhdosae9IdI=;
        b=eg8QpTpSt07wKi8670//4BhCccjZPpjLeZlKdZrDXilr6SC+nJF1Fd9FxKUDLXDKvp
         Qg0MUZE84SH50rypwbQa5pj/+LkqpJ2cfIb1SeAQtO5bkkuXs/onAx9xX2sqcbx9LsB3
         x71jQtS7P3Z2LDdEK05xhAXo7Vh9icJPnOmm01/wX+BW3PzLcTbRlf8PpSh5+jmwSl3w
         AlpVSD5TBb7+PXQPtCCYnmoXvgsM0Y4t4WY0qUOBKX7PgZe+d+O5xiAslmGI7Oj0lvCZ
         7AJXOIeqIfwbi+bTjvlAALJbFJFSaZJtBHB3sy5VeoNNTMKrp2IxT3w6JJmIBbM81+U1
         lSKQ==
X-Gm-Message-State: AOAM532caGFwb+pZQTCYqb1AJItYftzUbINloWgS04GZinkhhntjEjDZ
        g9IJptNHBZLhQk6Aod4r8/I=
X-Google-Smtp-Source: ABdhPJxchiADfRAR/sCX22jdFYhq6uNQt3ZtiLrehHbUn5gie/KsWK8GtqHQKvvv2zIKn0yEOXoKtA==
X-Received: by 2002:a17:90a:6281:: with SMTP id d1mr3940199pjj.231.1596125116442;
        Thu, 30 Jul 2020 09:05:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i66sm6453382pfc.12.2020.07.30.09.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 09:05:15 -0700 (PDT)
Subject: Re: [PATCH v4] usb: typec: tcpm: Migrate workqueue to RT priority for
 processing events
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20200730072531.3171984-1-badhri@google.com>
 <20200730123431.GO883641@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <33bec771-7255-517f-fb5f-9c4e7320837d@roeck-us.net>
Date:   Thu, 30 Jul 2020 09:05:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730123431.GO883641@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/20 5:34 AM, Heikki Krogerus wrote:
> Hi,
> 
> One more nitpick below...
> 
> On Thu, Jul 30, 2020 at 12:25:31AM -0700, Badhri Jagan Sridharan wrote:
>> @@ -4786,10 +4807,28 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
>>  	return PTR_ERR_OR_ZERO(port->psy);
>>  }
>>  
>> +static enum hrtimer_restart state_machine_timer_handler(struct hrtimer *timer)
>> +{
>> +	struct tcpm_port *port = container_of(timer, struct tcpm_port, state_machine_timer);
>> +
>> +	kthread_queue_work(port->wq, &port->state_machine);
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>> +static enum hrtimer_restart vdm_state_machine_timer_handler(struct hrtimer *timer)
>> +{
>> +	struct tcpm_port *port = container_of(timer, struct tcpm_port, vdm_state_machine_timer);
>> +
>> +	kthread_queue_work(port->wq, &port->vdm_state_machine);
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>>  struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>>  {
>>  	struct tcpm_port *port;
>>  	int err;
>> +	/* Priority just lower than default irq thread priority */
>> +	struct sched_param param = {.sched_priority = (MAX_USER_RT_PRIO / 2) + 1,};
> 
> Move that outside the function and constify it:
> 

Good catch. With this change applied:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>         static const struct sched_param param {
>                 .shed_priority = (MAX_USER_RT_PRIO / 2) + 1,

Caution: s/shed/sched/

>         };
> 
>>  	if (!dev || !tcpc ||
>>  	    !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc ||
> 
> thanks,
> 

