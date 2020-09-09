Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF1C10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E2D2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.go.id header.i=@mail.go.id header.b="j0s1TCCX";
	dkim=pass (2048-bit key) header.d=mail.go.id header.i=@mail.go.id header.b="4XirW6qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgIIRKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:10:53 -0400
Received: from sakti.mail.go.id ([103.8.238.38]:3902 "EHLO
        mailserver.mail.go.id" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730317AbgIIPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:03 -0400
X-Greylist: delayed 1328 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2020 11:35:02 EDT
Received: from mailserver.mail.go.id (mailserver.mail.go.id [127.0.0.1])
        by mailserver.mail.go.id (Postfix) with ESMTP id 4BmlNs2nn0z9JJHy
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 21:52:29 +0700 (WIB)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.go.id;
        s=default; t=1599663149;
        bh=kzJWSXLBri+2IYskEEy5zjDCo07ZCxJ+7J/ZvAzbPwk=;
        h=To:From:Subject:Date:From;
        b=j0s1TCCX+XGhgOyr3bd/WU82vAlv4ukZ51E6u8zcYN/nqDxAkP2fmGhPZcCCkJy1W
         EuA8U8r4zNMlcAz8gYme8uwvLAwuVrFKJ6Hih+n/2N9amk1RIgW30w4dyDMuN1QDhj
         onzfBDwFpFh0v0uTlCsqipmdkOX7z2bbP3RRFxQMVVQ+lEEb4P1n32rsm7iHeeuk1N
         uypkeTpvqecTapgiiBTcCTTu0V2laGNC4EeUC3NCMYQ3EGw0VojtzdbTsG1GJ9nX1t
         f41rFeZtOuObnpKmSKShh+YO4YQrdflZ7z4fCdTNpY/B+ikoF8IywiBE9BgpQKW8Sb
         cwfuHQFHKwwYw==
X-Virus-Scanned: Debian amavisd-new at mailserver.mail.go.id
Authentication-Results: mailserver.mail.go.id (amavisd-new);
        dkim=pass (2048-bit key) header.d=mail.go.id
Received: from mailserver.mail.go.id ([127.0.0.1])
        by mailserver.mail.go.id (mailserver.mail.go.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HXuJA95OeNJ9 for <linux-kernel@vger.kernel.org>;
        Wed,  9 Sep 2020 21:52:27 +0700 (WIB)
Received: from mail.go.id (unknown [14.169.252.80])
        by mailserver.mail.go.id (Postfix) with ESMTPSA id 4Bml836pHJz9BMqP;
        Wed,  9 Sep 2020 21:41:20 +0700 (WIB)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.go.id;
        s=default; t=1599662514;
        bh=kzJWSXLBri+2IYskEEy5zjDCo07ZCxJ+7J/ZvAzbPwk=;
        h=To:From:Subject:Date:From;
        b=4XirW6qg33xXQ4rrDPeP93kZXQQ5oA805NktRd0bNaonOglTbe1Ga35AN+muJQ9FC
         gL6eFK6QfWHRnkOhIuIqWGOQHe7sLAuXVDHT2vVSRnKOKqzUrdugptOD9aQokFwutl
         Yptd2puA8vzbfPvuK/pH4szyNrSd0Pa5EQSzsiVez0mgiOXZBoBqwymNAHtSeoDjby
         fx6eO2aJIWRhgiUFayl7KKbxNJGT1KPE5B9jBSpl7FMd95Vh6Pvhia8xvZ+Eu3WBRX
         r4EN/uqVGHSxVWtfwJvuvCBq6B3+thr2nMw4gIthkwFNq0OjlaBAzo4wa482qiQWKl
         MzX1+9irc93OA==
To:     "shilpa shet" <shilpa_shet@yahoo.com>,
        "karmachari5" <karmachari5@yahoo.com>,
        "pradhan" <pradhan@comcast.net>,
        "meena sathe" <meena_sathe@yahoo.com>,
        "unitedhindufront" <unitedhindufront@gmail.com>,
        "linux kernel" <linux-kernel@vger.kernel.org>,
        "eci sec jec nct delhi v k harit" <electionjec@gmail.com>,
        "eci ex KJ RAO" <kjrao27@hotmail.com>
From:   zamzam318 <eppi.permana@mail.go.id>
Subject: =?UTF-8?Q?=5BAttenzione!=5D_Mattina._Spero_?= =?UTF-8?Q?tu_stia_bene.?=
Message-ID: <cbad3eb9-c66c-40b0-b25b-071f73442e97@mail.go.id>
Date:   Wed, 9 Sep 2020 04:41:21 -1000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://bit.ly/3lAAQqz





Buon divertimento,zamzam318@yahoo.com

 




 =====================NEWS=====================



 Cutting down trash with bamboo packaging 
Universal Biopack makes packaging that it sells to restaurants and manufacturers. But rather than plastic, it uses a mixture of bamboo and cassava.

  

==============================================
