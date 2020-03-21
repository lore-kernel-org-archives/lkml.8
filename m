Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CF7C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1533120739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 19:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcast.net header.i=@comcast.net header.b="hqGQo+ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgCUTei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 15:34:38 -0400
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:59918 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbgCUTei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 15:34:38 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Mar 2020 15:34:38 EDT
Received: from resomta-ch2-10v.sys.comcast.net ([69.252.207.106])
        by resqmta-ch2-08v.sys.comcast.net with ESMTP
        id FibGj0dG8LoTbFjlNjhP7v; Sat, 21 Mar 2020 19:26:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1584818789;
        bh=vaeBmkVNINKx94yWt69KnTdaPQ9Bgw6KKAykYDGyWSU=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=hqGQo+wsIovdnAjC/CgAmjkF+/OUpwgGCec3gB3ugjWoZuP5q6DmlekF2ux3fOc+d
         449zJn4+CJp+nYWoGXFiplkH8qryT9dVfvN6bwrlZbXayKCrRVj8vuDJoye3UnKfvx
         OKyJNSeXNNAMDk9Co0fkBozVo78p8y4zbVbTqi9ji19JoxD/2dFtJPNFeAVtzvi9k+
         3hUJFiYxrDdiQkrDCr0LARhr7ttL12xzgLHo1CD/wMSlqKUifpKIm0IwdNCAYMPG9E
         5uJAb7eWbmhpa5yO40nEiRc7SKbknGaO/jir7ZLHKYDSBdJLwY2A0cYLsuWo+IVRkS
         fnftduycFR6yw==
Received: from [IPv6:2601:500:8303:76a0:eef4:bbff:fe36:426]
 ([IPv6:2601:500:8303:76a0:eef4:bbff:fe36:426])
        by resomta-ch2-10v.sys.comcast.net with ESMTPA
        id FjlLjUytkg6zoFjlNjOO5O; Sat, 21 Mar 2020 19:26:29 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
To:     linux-kernel@vger.kernel.org
From:   don fisher <hdf3@comcast.net>
Subject: help
Message-ID: <5cebdf24-9094-2291-61a9-edf1190e40e7@comcast.net>
Date:   Sat, 21 Mar 2020 12:26:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to change my subscription. How do I do it?
