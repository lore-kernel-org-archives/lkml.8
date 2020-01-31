Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B6C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C97620CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cW7pJggb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgAaIh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:37:56 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36350 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728099AbgAaIh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:37:56 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00V8WWYv021065;
        Fri, 31 Jan 2020 09:37:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=RvByVWKDnR1khDO+OZk/bWtvJxxsg3zo5oWTGlVFTCI=;
 b=cW7pJggbx3yrKAIItVkeJdJz8XFnekW5VBKJ9+R15zPyciyniAlMLSVdQRu/O5Orr219
 PyXaMkzgz7N0xEON0xL6FkfbNArnfv0lm3+kBIxEo4FRQvEdCcJqibbjE6/JmFS5eH96
 DDw5g6wKxrryDoLCklMK1UIG8HMRBWXwSOv0OJ3V/n81YSTFERFSTZ84KkkrvlXysKGq
 xv0/fU2qMMYE+kkQ+6SMkT5zAzlfjXnEgzOMsnFQLQOhEy+m/626IeY/wChEIwxLRMl+
 8d3mCNttMM79G87ZeevoOkNeNZoVzv+QNuva2+PwX3WRjY8MI6xOmBqaKsgNxr9s9VjM RQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrc13mmns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jan 2020 09:37:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4450910003B;
        Fri, 31 Jan 2020 09:37:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node3.st.com [10.75.127.21])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03CB921FEBF;
        Fri, 31 Jan 2020 09:37:28 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE3.st.com
 (10.75.127.21) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jan
 2020 09:37:27 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 31 Jan 2020 09:37:27 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "Loic PALLARDY" <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
Thread-Topic: [PATCH v2 2/7] bus: Introduce firewall controller framework
Thread-Index: AQHV1fD3WqS5xyjWNkazyajQl95bjqgAKU6AgAANnwCAAARlAIAAO2IAgADdioCAAALMAIAAF6SAgAL4AQA=
Date:   Fri, 31 Jan 2020 08:37:27 +0000
Message-ID: <0b109c05-24cf-a1c4-6072-9af8a61f45b2@st.com>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com>
 <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
 <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
 <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
 <20200129095240.GA3852081@kroah.com> <20200129111717.GA3928@sirena.org.uk>
In-Reply-To: <20200129111717.GA3928@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <638172DDBE744F46AA57A5E08293B1A9@st.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_02:2020-01-30,2020-01-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/29/20 12:17 PM, Mark Brown wrote:
> On Wed, Jan 29, 2020 at 10:52:40AM +0100, Greg KH wrote:
>
>> It just needs to be part of the bus logic for the specific bus that this
>> "firewall" is on.  Just like we do the same thing for USB or thunderbolt
>> devices.  Put this in the bus-specific code please.
> I'd expect that this is going to affect at least platform and AMBA
> buses.

Correct me if I'm wrong but creating a new type of bus would mean

that all the drivers living on this bus must be changed to register=20
themselves on this bus ?

Or does a solution exist to let them live on the platform bus and call=20
firewalled bus before been probed ?

All the impacted drivers could work on the existing bus with or without=20
the firewall so I don't want to break

that.

Benjamin
