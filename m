Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494C8C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2459A2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcBw8XlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgG0Hph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:45:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51015 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726973AbgG0Hpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595835934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMBVeCMrmTVhEtBWGjsG1unFoTQ5DrgjjzDJ6NMzZfs=;
        b=NcBw8XlUZ5Cm435c7oC2aPpbyvaDE5705DciVpP6XPz/UkpRwmBOen3ixcP1zz4k0TRwmI
        xpV2STdRyYnaAZQSK8RlqogxwxxWcLhTMhok4TgcCHHng5QBynPI5npJca8dYfKNfnsSNR
        TNxKEZUTTRdkkhvoh/81Y6fpIAeWm9o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-HmlHrQImNCenUNgGRXj3oA-1; Mon, 27 Jul 2020 03:45:33 -0400
X-MC-Unique: HmlHrQImNCenUNgGRXj3oA-1
Received: by mail-ed1-f69.google.com with SMTP id v11so1992785edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oMBVeCMrmTVhEtBWGjsG1unFoTQ5DrgjjzDJ6NMzZfs=;
        b=UZHWqJ1Hja4lH7XaNoEkAdFQ0qALm2ZeWrv5E4Aw6DyL/WfvPckc3EVvfs2efQm2yH
         8K0mnLUFtMOo78b7Qa7Z7USJDOlgAwTuu9+wJvBugX6OMzZErIAHeV2Uz6X7cV2lq1Dh
         kQ547u2b6juiOURkE1gs+dythFZSysGQzuteUdWy6C8Mw5gW46+y7y/9VdsSPARsTJtV
         Xn3zJWl07H53wVVxvkGf3yTEcI3rYM2yvgd//gEivv1ll7RcC1o/Q+Zo9+ydQcZYshcj
         1j9mifLQlrEerIZl4S/cTwGIry+rWkfXeZUZnkE7Q6sgDg0Ah5Cuq8+1OlKsM6GyMR5x
         MkQA==
X-Gm-Message-State: AOAM533p6dCQKZ77KkNfBALqlZaJRBXzj1RsfNswKO34OeVzc+K+WfYa
        vmRHZ0z5c6Pk9CVdNo1yaTqKBQzaFl+tU9ojxfkWbzFVxBdBUse0UIUENH5aMyQN9UB4Hyn6lAL
        pStJWHfKBbC0ikBHG3TV4EH/g
X-Received: by 2002:a17:906:b294:: with SMTP id q20mr2115098ejz.223.1595835931531;
        Mon, 27 Jul 2020 00:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfnpzm5w2mw/jNUlDtxiqUY/d9iJ0u0qln5b8dW/aH3LeubhQN1b6Sy5Yno4zk+7u2dQ26dw==
X-Received: by 2002:a17:906:b294:: with SMTP id q20mr2115093ejz.223.1595835931381;
        Mon, 27 Jul 2020 00:45:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r25sm5659889edy.93.2020.07.27.00.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 00:45:30 -0700 (PDT)
Subject: Re: [PATCH 0/3] Add 3 new keycodes and use them for 3 new hotkeys on
 new Lenovo Thinkpads
To:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input@vger.kernel.org,
        Marco Trevisan <marco.trevisan@canonical.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Christian Kellner <ckellner@redhat.com>,
        Benjamin Berg <bberg@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717114155.56222-1-hdegoede@redhat.com>
 <20200719225649.GA4341@khazad-dum.debian.net>
 <20200722054144.GQ1665100@dtor-ws>
 <20200727005049.GA10254@khazad-dum.debian.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f67ede61-c9d4-6abc-9b59-a5b2b615d1b6@redhat.com>
Date:   Mon, 27 Jul 2020 09:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200727005049.GA10254@khazad-dum.debian.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/27/20 2:50 AM, Henrique de Moraes Holschuh wrote:
> On Tue, 21 Jul 2020, Dmitry Torokhov wrote:
>> On Sun, Jul 19, 2020 at 07:56:49PM -0300, Henrique de Moraes Holschuh wrote:
>>> On Fri, 17 Jul 2020, Hans de Goede wrote:
>>>> This is a simple patch-series adding support for 3 new hotkeys found
>>>> on various new Lenovo Thinkpad models.
>>>
>>> For all three patches, pending an ack for the new keycodes by the input
>>> maintainers:
>>>
>>> Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
>>
>> Do you want me to merge all 3 through input tree?
> 
> Hans, Daren, Andy, what do you prefer?

Taking all this upstream through Dmitry's input tree is fine with
me, but this really is up to Andy and/or Daren.

Regards,

Hans

