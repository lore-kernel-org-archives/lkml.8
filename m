Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91355C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6943720773
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 01:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgICB7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 21:59:02 -0400
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:57856 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgICB7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:59:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5F42B18029587;
        Thu,  3 Sep 2020 01:59:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: gun42_4f15721270a5
X-Filterd-Recvd-Size: 1615
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Sep 2020 01:59:00 +0000 (UTC)
Message-ID: <71837114676678d44500f146a2d98bbe9e541c65.camel@perches.com>
Subject: Re: [PATCH v2] use cpu_to_le{16,32} instead of __constant_cpu_to_*
From:   Joe Perches <joe@perches.com>
To:     Rene Rebe <rene@exactcode.com>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, himanshu.madhani@oracle.com
Date:   Wed, 02 Sep 2020 18:58:59 -0700
In-Reply-To: <20200902.232949.1343752343092794969.rene@exactcode.com>
References: <b7719680-e451-5687-1fb7-c8c059a880d4@acm.org>
         <2C755628-1426-4BA4-B2A3-AD059BB0F605@exactcode.com>
         <c7daea00-410d-2073-bf52-2abda9acdf8e@acm.org>
         <20200902.232949.1343752343092794969.rene@exactcode.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-02 at 23:29 +0200, Rene Rebe wrote:
> As per recommendation, convert a few remaining __constant_cpu_to_le{16,32}
> instances in the qla2xxx, qla4xxx and cifs to just cpu_to_le{16,32}.
[]
> diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
[]
> @@ -3583,7 +3583,7 @@ static int __qlt_send_term_imm_notif(struct scsi_qla_host *vha,
>  
>         /* terminate */
>         nack->u.isp24.flags |=
> -               __constant_cpu_to_le16(NOTIFY_ACK_FLAGS_TERMINATE);
> +               cpu_to_le16(NOTIFY_ACK_FLAGS_TERMINATE);

trivia: this now fits on a single line.


