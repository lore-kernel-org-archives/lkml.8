Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4236C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9809C20716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwJYdbNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbgFWNKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:10:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49752 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729504AbgFWNJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592917797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zkx1ErBA+e2/cfoAENc9bfwtwsTIO4mVEVPpuQkBgT4=;
        b=GwJYdbNWGdCYewTdkuMcfbTm4t+i31R4X9oCCltrryKENtJj/UWhfU5S0d4bdJ6hCLhfJP
        XuQjnKlhqZRZcjhPMduM+UIo+nWtjHF2sqcq2r/YpE9OOFlV3A9XM7SJOxKZE9zXgtegGm
        3EtsoGXXKAixn7r3ZcYpuZJpwGXrXaM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-dVAkXxbuO8aPDN-VfMNqcg-1; Tue, 23 Jun 2020 09:09:56 -0400
X-MC-Unique: dVAkXxbuO8aPDN-VfMNqcg-1
Received: by mail-ed1-f69.google.com with SMTP id a21so10422655edy.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zkx1ErBA+e2/cfoAENc9bfwtwsTIO4mVEVPpuQkBgT4=;
        b=GqUwh10QU5bKk6oTxjcIbSE9XeMY1mq6H/CuLBXI+G4WJW6+qBUrr+TSO7dJfabobH
         hd8ofmIJk+NQ/6bsh35420F29GBsjt138eYjIfM3aI5qC2Ix+3E6llfM8oU8EfK3kna0
         lhcBM/kfvWPPMMadwlS8ROrje4UcSWisCk0QxaG/hazWBkxK3EaVSobXSguK8T3nQdSz
         mzYNDyISmU2+7Bi+Ou/sdnlb6C7hFtemvSQ5GxTWIi7Dsfm21tEuV6qh5KhLuIVrFrD7
         uWHsPC6yhxvTVbAIftAs3EibvaEwSN4LVbvvd0DBuzg6qGai5S1hLO79MaGyflTFj2BT
         uEoQ==
X-Gm-Message-State: AOAM531P3qrLLbOQ4g7eqbwOKYd1um1sBzC0yN635VTGJT0Lw4NZVKB2
        V0ixNql/ITW5IW8CIjQfcLbpBQo9A/Z/G81++dTuj3hT90hxfpWDEYJOIOcvcyNZzCrrJmKP4Qh
        BK6aU5+rXsF9d4gLjwzMc79rx
X-Received: by 2002:a17:906:93f7:: with SMTP id yl23mr20041168ejb.366.1592917793746;
        Tue, 23 Jun 2020 06:09:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4y3aEtz58QMxkXLbJ2y2yFeesR5msJNak4RPLHWT6aKhj4HhSd1IzuBmsTRod7a3vvSLz3g==
X-Received: by 2002:a17:906:93f7:: with SMTP id yl23mr20041156ejb.366.1592917793534;
        Tue, 23 Jun 2020 06:09:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v5sm13582802ejx.123.2020.06.23.06.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 06:09:52 -0700 (PDT)
Subject: Re: [PATCH 5/8] virt: vbox: Add support for the new
 VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200520195440.38759-1-hdegoede@redhat.com>
 <20200520195440.38759-5-hdegoede@redhat.com>
 <CAK8P3a1sDRsfsmPf4=Q3mG75VVNoD3CC7Rrgb4BZMEEfTu66qA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c81cd7ac-a698-8d9b-c5c1-6a4e0bc90966@redhat.com>
Date:   Tue, 23 Jun 2020 15:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1sDRsfsmPf4=Q3mG75VVNoD3CC7Rrgb4BZMEEfTu66qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the review and sorry for being slow with
responding.

On 5/20/20 11:47 PM, Arnd Bergmann wrote:
> On Wed, May 20, 2020 at 9:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Add support for the new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl, this
>> is necessary for automatic resizing of the guest resolution to match the
>> VM-window size to work with the new VMSVGA virtual GPU which is now the
>> new default in VirtualBox.
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1789545
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> This is not a great interface, but I see no bugs in the implementation
> or problems with portability.
> 
> If you want to improve it a little bit, note that spin_lock_irqsave() inside
> of mutex_lock() is a little bit silly since you know at this point that
> interrupts are enabled and you could use spin_lock_irq() instead.
> 
> I assume the driver does the same thing everywhere but I did not check.

Yes the driver does the same everywhere and TBH I would prefer to keep
it that way, this all is not that performance critical and in my experience
once a driver starts using the less save variants it is easy for some
mistakes to creep in.

As for the rate-limiting of the printk remark you made in reply to the
"virt: vbox: Log unknown ioctl requests as error" patch that is a valid
remark. I will prepare a v2 of this patch-set addressing that.

Regards,

Hans

