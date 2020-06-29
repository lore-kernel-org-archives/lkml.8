Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C279C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 124D020656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391920AbgF2WGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:06:43 -0400
Received: from muru.com ([72.249.23.125]:59940 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgF2SfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:14 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 590AB81C2;
        Mon, 29 Jun 2020 18:27:18 +0000 (UTC)
Date:   Mon, 29 Jun 2020 11:26:22 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 07/10] regulator: cpcap-regulator: Remove declared and
 set, but never used variable 'ignore'
Message-ID: <20200629182622.GC37466@atomide.com>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
 <20200625191708.4014533-8-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625191708.4014533-8-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Jones <lee.jones@linaro.org> [200625 19:18]:
> It's okay to not check the return value that you're not conserned
> about, however it is not okay to assign a variable and not check or
> use the result.
> 
> Fixes W=1 warnings(s):
> 
>  drivers/regulator/cpcap-regulator.c:172:13: warning: variable ‘ignore’ set but not used [-Wunused-but-set-variable]
>  172 | int error, ignore;
>  | ^~~~~~
>  drivers/regulator/cpcap-regulator.c: In function ‘cpcap_regulator_disable’:
>  drivers/regulator/cpcap-regulator.c:196:13: warning: variable ‘ignore’ set but not used [-Wunused-but-set-variable]
>  196 | int error, ignore;

Acked-by: Tony Lindgren <tony@atomide.com>
