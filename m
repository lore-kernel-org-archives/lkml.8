Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54089C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33A7020888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590544130;
	bh=VZwcUR9cJJ5Xu2VihzOLcu/j5MKsW+XtUi/R0QgbwUw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=hIWET5qrlTSCJU4Fd3NGxbyu+UJO7YcHpX/v+sARAj0zmavVoJqvbqo12F203Yujj
	 vAi20GGVp/xGrX3gRzv+e4KKTPoqL7aJH48GAskGdNrufWi+wbAUzWDj9Ut6JaMn4b
	 GyH5JoX3iOz5VYPl7nMIs3+GCrrLZkj2Vj/6adlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgE0Bst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgE0Bst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:48:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78235207CB;
        Wed, 27 May 2020 01:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590544128;
        bh=VZwcUR9cJJ5Xu2VihzOLcu/j5MKsW+XtUi/R0QgbwUw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hk2+02Bi3/1PeI7+An0+K2JTNQSaqNnXeXmc24FjgomYp+FUKQfSUw6UGEd7oNxnE
         D9Z/pUExuq9THOLTg9PAKUx3sU5T4/bq95CkfGVruMnIJbaqt4etVrkVZ7X+xgBcs2
         61fQWm/nrfti/FenmV7aih1qvNA5eLusl7zBPQdw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8dce2be13195aab20c6b11fca6af0fffe22d5241.1587102634.git.rahul.tanwar@linux.intel.com>
References: <cover.1587102634.git.rahul.tanwar@linux.intel.com> <8dce2be13195aab20c6b11fca6af0fffe22d5241.1587102634.git.rahul.tanwar@linux.intel.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: clk: intel: Add bindings document & header file for CGU
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
Date:   Tue, 26 May 2020 18:48:47 -0700
Message-ID: <159054412768.88029.14426898331029456551@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2020-04-16 22:54:46)
> Clock generation unit(CGU) is a clock controller IP of Intel's Lightning
> Mountain(LGM) SoC. Add DT bindings include file and document for CGU clock
> controller driver of LGM.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---

Applied to clk-next
