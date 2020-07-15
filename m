Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0EBC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B040920663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0ViChu9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGOQIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:08:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgGOQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:06:58 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FFqh3d030962;
        Wed, 15 Jul 2020 18:06:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=VxjdMpcXN79GVQ3jPVzbk6I3tuoSCoV11faoa+SlGGI=;
 b=0ViChu9TZbG0vELUnZ7hnwVFkWnPfXUPZz421JH2+6TXkR5fxPnr/4AoGEmRaMyA5o0E
 JFk++uqxQVxM5ZYzB46rsxykc7Cug2RIlRCCZzEGGQjq5PEIHpm/2gB7Tf51EhNkx8Wy
 B01ZOsma7XtWsXpt5kDx/HaDEzXXk+pgHJhXgfzOQRAOD7KSQ4FpLKZLCF5To8rNTdB5
 66b9vsHxt5B+TXyCzAP102i4z7jYJERv94CWYC+vlL3wopBpEqFryMf8exnoZKr/TgRp
 33eKppjknyx4WJY8LZTsaiEaFx3b7uK9OWzT1694oaeHAXg7PFBKuZsqBQJ3HUK7tlqv Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 327cyv5baq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 18:06:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9A85910002A;
        Wed, 15 Jul 2020 18:06:37 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 825E12AEEA6;
        Wed, 15 Jul 2020 18:06:37 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jul
 2020 18:06:36 +0200
Subject: Re: [PATCH v7 0/2] Add rpmsg tty driver
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        xiang xiao <xiaoxiang781216@gmail.com>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <98271538-d7b4-cf48-abda-3a6c8cd45ee5@st.com>
Date:   Wed, 15 Jul 2020 18:06:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200324170407.16470-1-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/20 6:04 PM, Arnaud Pouliquen wrote:
> This patch set introduces a TTY console on top of the RPMsg framework which
> enables the following use cases:
> - Provide a console to communicate easily with the remote processor application.
> - Provide an interface to get the remote processor log traces without ring
>   buffer limitation.
> - Ease the migration from MPU + MCU processors to multi core processors
>   (MPU and MCU integrated in one processor) by offering a virtual serial link.
> 
> An alternative of this proposed solution would consist in using the virtio
> console:
> The drawback with that solution is that it requires a specific virtio buffer
> (in addition to the one already used for RPMsg) which does not fit with remote
> processors with little memory. The proposed solution allows to multiplex the
> console with the other rpmsg services, optimizing the memory.
> 
> The first patch adds an API to the rpmsg framework ('get max transmission unit')
> and the second one is the rpmsg tty driver itself.
> 
> Previous revision:
> - the patch 1/2 ("rpmsg: core: add API to get MTU) has been discussed in a
>   separate thread on remoteproc mailing list:
>     https://patchwork.kernel.org/patch/11333509/
> - Previous version of the patch 2/2 (tty: add rpmsg driver) available here:
>     https://patchwork.kernel.org/cover/11130213/
> 
> Main delta vs v6:
>  - Pack the rpmsg_tty_ctrl struct.
>  - MTU API acked by Suman Anna from Texas Intruments company. 
> 
> Arnaud Pouliquen (2):
>   rpmsg: core: add API to get MTU
>   tty: add rpmsg driver
> 
>  Documentation/serial/tty_rpmsg.rst |  45 ++++
>  drivers/rpmsg/rpmsg_core.c         |  21 ++
>  drivers/rpmsg/rpmsg_internal.h     |   2 +
>  drivers/rpmsg/virtio_rpmsg_bus.c   |  10 +
>  drivers/tty/Kconfig                |   9 +
>  drivers/tty/Makefile               |   1 +
>  drivers/tty/rpmsg_tty.c            | 417 +++++++++++++++++++++++++++++
>  include/linux/rpmsg.h              |  10 +
>  8 files changed, 515 insertions(+)
>  create mode 100644 Documentation/serial/tty_rpmsg.rst
>  create mode 100644 drivers/tty/rpmsg_tty.c
> 

Series put on hold after discussion with Bjorn. First we need to define the interface and mechanism
to allow any service name to be associated with an rpmsg service based on the IOCTL user interface. 
The goal is to allow the Linux application to initiate the link. This work will be done on the 
rpmsg char and then extend to other generic interfaces such as TTY.
