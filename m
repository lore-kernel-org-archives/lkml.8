Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E5C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E92320767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wUMtrNKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgIAMjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:39:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30441 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgIAMjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:39:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598963956; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=4BZWAUdP2BV+O/N6ISnmEaCGS3o7RyPMKfE16SuDwv4=; b=wUMtrNKFWc8b0pNLhBKpGaoUVbhj0b/0TBlREGfU8PRYQGjO2/tt7Xdiugc3iS5wiHP6DR11
 22RX4j9I0b9nP2V4nInYX0n7/NCIcm+1UOtRdyPcleX32HWblzGiXPOoFVd63n2rUcqMgmkO
 lhNOmRlxxoMpJeSkNT9GcGeQntI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f4e40eabe06707b34767a68 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 12:39:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92071C433CA; Tue,  1 Sep 2020 12:39:06 +0000 (UTC)
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23DD6C433C9;
        Tue,  1 Sep 2020 12:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23DD6C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <kvalo@codeaurora.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] ath6kl: wmi: remove set but not used 'rate'
References: <20200831080824.3249197-1-yanaijie@huawei.com>
Date:   Tue, 01 Sep 2020 15:38:58 +0300
In-Reply-To: <20200831080824.3249197-1-yanaijie@huawei.com> (Jason Yan's
        message of "Mon, 31 Aug 2020 16:08:24 +0800")
Message-ID: <871rjl7jtp.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Yan <yanaijie@huawei.com> writes:

> This addresses the following gcc warning with "make W=3D1":
>
> drivers/net/wireless/ath/ath6kl/wmi.c: In function
> =E2=80=98ath6kl_wmi_bitrate_reply_rx=E2=80=99:
> drivers/net/wireless/ath/ath6kl/wmi.c:1204:6: warning: variable =E2=80=98=
rate=E2=80=99
> set but not used [-Wunused-but-set-variable]
>  1204 |  s32 rate;
>       |      ^~~~
>
> The variable 'sgi' is alse removed because after 'rate' is removed, it
> is not used too.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Already fixed in ath.git tree.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
