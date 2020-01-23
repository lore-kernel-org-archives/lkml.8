Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2D3C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2977622522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 07:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgAWHEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 02:04:40 -0500
Received: from [175.24.100.79] ([175.24.100.79]:35452 "EHLO mail.kaowomen.cn"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAWHEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 02:04:40 -0500
Received: by mail.kaowomen.cn (Postfix, from userid 5002)
        id 6C067E12EA; Thu, 23 Jan 2020 15:04:35 +0800 (CST)
Date:   Thu, 23 Jan 2020 15:04:35 +0800
From:   me@kaowomen.cn
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        'Valdis Kletnieks' <valdis.kletnieks@vt.edu>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>,
        "'linux-fsdevel@vger.kernel.org'" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] staging: exfat: remove fs_func struct.
Message-ID: <20200123070435.cjso5yh6nmmhd4gm@kaowomen.cn>
References: <20200117062046.20491-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200122085737.GA2511011@kroah.com>
 <OSAPR01MB1569F24512678DEA1C175504900F0@OSAPR01MB1569.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OSAPR01MB1569F24512678DEA1C175504900F0@OSAPR01MB1569.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 06:38:53AM +0000, Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
>Hello, Greg.
>
>Thank you for the quick reply.
>
>> Also the patch does not apply to the linux-next tree at all, so I can't take it.
>The patch I sent was based on the master branch of “https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/”
>and its tag was v5.5-rc6.
>
>> Also the patch does not apply to the linux-next tree at all, so I can't take it.  Please rebase and resend.
>I will send a new patch based on the latest master branch of “https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git”.
>
>
>By the way, could you answer below questions for my sending patches in future?
>1. Which repository and branch should be based when creating a new patch?
>2. How do I inform you about a base on which I create a patch?
If you like you can add [PATCH -next] to patch title before send it. :)
BR,
>
>--
>Best regards,
>Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
