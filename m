Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD189C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31DD206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506663AbgDPLvJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:51:09 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:37286 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504790AbgDPLu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:50:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 9DE8127E0B48;
        Thu, 16 Apr 2020 13:50:55 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id h6uaCYF89kXr; Thu, 16 Apr 2020 13:50:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 69CD127E0B5E;
        Thu, 16 Apr 2020 13:50:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ufvqwe-r4Gu5; Thu, 16 Apr 2020 13:50:55 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 56C0127E0B48;
        Thu, 16 Apr 2020 13:50:55 +0200 (CEST)
Date:   Thu, 16 Apr 2020 13:50:55 +0200 (CEST)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalrayinc.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <622416308.15749883.1587037855167.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20200416113539.GG5354@sirena.org.uk>
References: <20200416110823.22565-1-cleger@kalray.eu> <20200416110916.22633-1-cleger@kalray.eu> <20200416110916.22633-2-cleger@kalray.eu> <20200416113539.GG5354@sirena.org.uk>
Subject: Re: [PATCH 2/2] spi: dw: remove cs_control and poll_mode members
 from chip_data
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF68 (Linux)/8.8.15_GA_3895)
Thread-Topic: remove cs_control and poll_mode members from chip_data
Thread-Index: H1Aqi4omUkzlnJc0pg+nDZ3opzqhcA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Sorry, maybe the commit message was not clear enough but actually
these fields were not initialized so it does not break anything
(ie, the default values were always used).

Clément

----- On 16 Apr, 2020, at 13:35, Mark Brown broonie@kernel.org wrote:

> On Thu, Apr 16, 2020 at 01:09:16PM +0200, Clement Leger wrote:
>> Since these members were initialized only with previous dw_spi_chip
>> struct members and that there is no user anymore, remove them. Along
>> this removal, remove code path which were using these members.
> 
> This means that your first patch will break the build, to keep things
> bisectable please do some combination of moving this before the first
> patch and squashing it into the first patch.
