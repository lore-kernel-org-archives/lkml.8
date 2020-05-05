Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CEBC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F41620661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgEEOAx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:00:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55372 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgEEOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:00:52 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVy7u-0000Zb-Kh
        for linux-kernel@vger.kernel.org; Tue, 05 May 2020 14:00:50 +0000
Received: by mail-pj1-f69.google.com with SMTP id z22so2662559pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Tmt1kAkSNgDDA6SgCoiKzqt8Vdok8wOVXa0LwLlOOZU=;
        b=ZRiZnAUg21/NXnjd4IzOAc5NoPtLJ1xe/9fXEgAsoMgYtPhW8AxWsVDOONW0imkuBA
         NuzNn8KVyLtzt2Cl4FGAeROV11+7Ikmh+IpCm5XoDUZKlhMIE7Gh1DdtS6eRnx43MN2U
         sVuRILHMa0LbtHqdO1RwdePYa6ifEcuD/c8CtEYPh6wXV1BFMdUDbe9FKNtyueGnVyf6
         B0BUSd7wFt3puYGQCA/hJDFtRIJrQ2mmZIngGJuN81JOTDuWkeNyqHGrpS+uQrvtx2+j
         1lTftjH54NOij4YONR+5wUyrg8t9Kq7oA5pxysRABIyssOXAYbKm6ZFeE4vCG8dCenu7
         f8hg==
X-Gm-Message-State: AGi0PuaFmsrqbIg6NAE7QGnAsKcRQsn2jlZ+eJGYCUFQLj35MpDHoFOl
        MaPwuz4tv6H82fbCIfheRwOXuZrAhB9dRIhDuv8cKrYvvEOxt8vrjKnBkwYq6h6MQqx23jfn1Ec
        D1381EJLPZ0RsJ5cnD9mU4g8gMdUVNtQZAQn05yW2Xg==
X-Received: by 2002:a17:902:ea86:: with SMTP id x6mr2988474plb.75.1588687248904;
        Tue, 05 May 2020 07:00:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKoro7cEao2ONYO3zXMXFh9sQspXjrC68hvKiS5R86yKK21qYdpckzfRBbNmL5QHsMRvuIvAA==
X-Received: by 2002:a17:902:ea86:: with SMTP id x6mr2988449plb.75.1588687248460;
        Tue, 05 May 2020 07:00:48 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z60sm2236850pjj.14.2020.05.05.07.00.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 07:00:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2] PCI/ASPM: Enable ASPM for root complex <-> bridge <->
 bridge case
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200505133812.GA353121@bjorn-Precision-5520>
Date:   Tue, 5 May 2020 22:00:44 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B6977248-C345-466D-AE8B-600088B73FA8@canonical.com>
References: <20200505133812.GA353121@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 5, 2020, at 21:38, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Tue, May 05, 2020 at 08:27:59PM +0800, Kai-Heng Feng wrote:
>> The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
>> state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
>> power. On Windows ASPM L1 is enabled on the device and its upstream
>> bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
>> power.
> 
> The above is a benefit, but leading off with it suggests that this
> change is specifically for that config, which it isn't.

Yes, it applies all devices that meet the condition.

> 
>> Currently, ASPM is disabled if downstream has bridge function. It was
>> introduced by commit 7d715a6c1ae5 ("PCI: add PCI Express ASPM support").
>> The commit introduced PCIe ASPM support, but didn't explain why ASPM
>> needs to be in that case.
> 
> s/needs to be in that case/needs to be disabled in that case/ ?

Yes indeed I missed that word...

> 
>> So relax the condition a bit to let bridge which connects to root
>> complex enables ASPM, instead of removing it completely, to avoid
>> regression.
> 
> If this is a regression, that means it used to work correctly.  So are
> you saying 7d715a6c1ae5^ works correctly?  That seems doubtful since
> 7d715a6c1ae5 appeared in v2.6.26 and added ASPM support in the first
> place.

Clearly I didn't express my intention well enough.
What I meant was, we can either remove the "disable ASPM on bridge" case completely, or do what this patch does.

> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/pci/pcie/aspm.c | 14 ++++++++------
>> 1 file changed, 8 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 2378ed692534..af5e22d78101 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -629,13 +629,15 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>> 	/* Setup initial capable state. Will be updated later */
>> 	link->aspm_capable = link->aspm_support;
>> 	/*
>> -	 * If the downstream component has pci bridge function, don't
>> -	 * do ASPM for now.
> 
> I agree, that comment is missing the essential information about *why*
> we don't do ASPM.

Or missing a part to re-enable ASPM in later time.

> 
>> +	 * If upstream bridge isn't connected to root complex and the
>> +	 * downstream component has pci bridge function, don't do ASPM for now.
> 
> But this comment just perpetuates it and makes the special case even
> more special.  I think we should either remove that special case
> completely or figure out what the real issue is.

I do prefer remote it completely, but I was afraid of introducing any regression so I just made the case more "special".

> 
> I know we weren't always very good about computing the acceptable
> latencies (and we still don't handle LTR correctly, though that's an
> L1 Substates issue that wouldn't have applied in the 7d715a6c1ae5
> timeframe).

Seems like Windows doesn't disable ASPM on bridge to bridge case, can we take the risk and remove the special case completely?

Kai-Heng

> 
>> 	 */
>> -	list_for_each_entry(child, &linkbus->devices, bus_list) {
>> -		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
>> -			link->aspm_disable = ASPM_STATE_ALL;
>> -			break;
>> +	if (parent->bus->parent) {
>> +		list_for_each_entry(child, &linkbus->devices, bus_list) {
>> +			if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
>> +				link->aspm_disable = ASPM_STATE_ALL;
>> +				break;
>> +			}
>> 		}
>> 	}
>> 
>> -- 
>> 2.17.1

