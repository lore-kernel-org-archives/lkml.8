Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75797C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E89A2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=guestpostingagency-com.20150623.gappssmtp.com header.i=@guestpostingagency-com.20150623.gappssmtp.com header.b="pF5w/jAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgIGR0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbgIGNUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:20:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB1C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:20:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so15750972wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guestpostingagency-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=FsQLSqbxO2hcJKgtSJSicQP9qAJejvvjRZLoT/wDhdM=;
        b=pF5w/jAnG02JCgsrI1KPeaK6loin2vxWi/V12tAOq0cUwF2JlkmdsE80bv1q/jyPQC
         PCbIq3qf6St4z0Hun4+fIebtTdPNWbl2zPn9a6Eqe++6G6g6eppSwgkA3kQi6qKOfntD
         j9c8rMYaUNUKcyu9jbM+hB/8UKMcxhkIqD3LmAH72bwZ82VLdfeMR6YVRMrZ9SGd3uHr
         LpbR7YLHP5SO+hcu64fV9asd9cd+mngRpkoxrsmo5jdIJvjEBUYeoTBaWPDHE8uWymvS
         1thIqIktVoeoWeJ0DGew5hGt4byKgh8Vz8BR17+5fXUtJD6UKGcBCoadgXrax3c7zy9f
         mLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=FsQLSqbxO2hcJKgtSJSicQP9qAJejvvjRZLoT/wDhdM=;
        b=gL3l5CuGaiq/wnHDiTeFsHr2wsOcYJpiwF3VnSf/8JQ5wyNVp5Oj0TuErCxMXDHXvz
         3GCV9ymyxD+uE37T7+IOExqVG7M+s9OkBMXJlePeynq0GUeivV4se6hNXnc6MCXlXhLW
         +u08ielaiUXxziyKFS6/9CJfwO5RxqSr2wD8KFSOzayqjClbaNe0z31Tb/yNu3bAWkD1
         zryeuPuV1NZO5EXUsN+dse+eurT0X28S0KiC3JmkKvhupLIX6vgK3kxDojT/OCCq7Pzw
         cCWGbMZRvvvAORdvP5jKGrI06uP5eLIQNygb6MF7esgfrNJ96TK+4VOrPsb2VHJuHkiL
         u62Q==
X-Gm-Message-State: AOAM530wjoFhWYjtbl2rxXO8sKZwsT6o88SLRaxzEVSX+c2hSag6QBUp
        ndxmtPOYRaGbGVm40Y9Qzgpc4+AHnnJ3aqYg
X-Google-Smtp-Source: ABdhPJx8pwuw8BOobEV32kQVAU3XL5hLhVF+nvg2b7NJ/wj1618Oj+LeiLWMiGb58Mi16oLWpz83gg==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr21307289wrm.355.1599484816050;
        Mon, 07 Sep 2020 06:20:16 -0700 (PDT)
Received: from 72.255.36.144 ([72.255.36.144])
        by smtp.gmail.com with ESMTPSA id d18sm28435392wrm.10.2020.09.07.06.20.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 07 Sep 2020 06:20:15 -0700 (PDT)
MIME-Version: 1.0
From:   "Edward Blackford" <edward@guestpostingagency.com>
Reply-To: edward@guestpostingagency.com
To:     linux-kernel@vger.kernel.org
Subject: Paid Post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Mon, 7 Sep 2020 18:20:11 +0500
Message-ID: <12312378262528479214065@DESKTOP-FB7ULH6>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Hope you are having a great day! I have come across your site, and I strong=
ly feel that your website is a perfect match for us.
We are a content marketing agency, and we=92d be thrilled if you=92d allow =
us to post relevant and non-promotional content on your website. You can he=
lp us by placing an article with a do-follow link on your site.
Let us know how much you charge for a do-follow link. We make payments thro=
ugh PayPal. We look forward to having a long-term relationship with you.

We=92ll be happy to hear from you soon.



Kind Regards
