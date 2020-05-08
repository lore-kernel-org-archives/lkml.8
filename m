Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638D8C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303F220870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qH6uPzMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEHLbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:31:19 -0400
Received: from mout.web.de ([212.227.15.3]:44525 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHLbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588937433;
        bh=u/FNWLuypt5s35PKIj0G9HLr6/vRXkLpilIHRs4f1ic=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qH6uPzMWD+HXgjUHJYDipNi743zwy3YW0bVXen1OoxdLubF7F0v3fNbKlLt3Duw3X
         0jv8ed9Mb55fhhJB56ZczLw6cPCHMZO6p1JhWG0eH58wIrOjklcmh1dyC69OcVqeDM
         jsVicy6oE2BVxDFgCnGI/nMM/xuyok0Nklaewulw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.146.138]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MD5nx-1jNyno0tDV-009C8e; Fri, 08
 May 2020 13:30:33 +0200
Subject: Re: [v3] tools/bootconfig: fix resource leak in apply_xbc()
To:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
 <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
 <559edb00-a03b-747e-8ba7-1f16285deefb@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <65057e82-8002-4ec4-b714-25ac8d05cb68@web.de>
Date:   Fri, 8 May 2020 13:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <559edb00-a03b-747e-8ba7-1f16285deefb@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:mxWcOJKS4S1xIswBU+3JdWa86X74HQrC+X82cNqndyVUcyFME0+
 Z2xTSjKJLT2+VdLMnw8RH68DEZj7pjLTttg42Cxzm+6houneklwiWl7sZYkXjcJGBhUDwIj
 bBB4iyekjVbN6ghRHctzeDYv5dgUHVV6UYk48z65808o++5cytn/kHD9jIGN+zudIMWZwws
 8OH5+/e2PstJqTheuGMTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6y0FxoqsIhs=:3FvJdVfxhhpGFWq/hulYy6
 Xx7B/81eZl9NUvFxNYGx/glLDzFppLZnZmQMcSksYnhQTyQ15xO9mltiH9VQmgxFsh940AdYJ
 T7Zbtjw4NCLiJaX8URLdUEa7x/UjXcsb3Lr43JDzueI93Gd4WRRaWz4HS7yAPSD51vhicpJjn
 H9W60xRhrGRArpSNI/r/MpKRtUJgKUOTDdkwFcBR7aTTkQhMVSU4m35OFnBIvWPeQThX4FaMU
 Ro5b5B1Ykz5rcFlYC1lO9YR7XIYKKbSuH6T5pI8xDY6ttQhlQYt7QRBwWT9IxYduO2+BqlmGA
 /ARcNG1qN9CPUs4x0bPYVztwWr/yM6+evWTqUFHyGHxNQKPQLf4+wRPR4MkQ+tD71H+Rt2Zfk
 cFr88P8sqEp6FEgWQEYfs4NUA1059OJXY4m9rzAnDWE+DzCOT6TBxFSy1y2QvOpGZgQC2eA63
 TGZfpT8t3nHmUQM+2GUGI2CQQeFUfzhAryDUsSjE5cQtDj0rNDleeelQThT/MI3Z6oXWPFGKI
 hn46aesd53Podx1CABk8yoqnVv1zSsLwshpD3koHWN0RacHBD2KPDVHWukir6KVft3SWy/Npp
 jeq0LVuLNO3yBMjtvFGefoDrT1NykNAz0msRi/8tXRmoc4wMh9tLHhpm3RWEE6X+DbNJHaAkP
 ykRYzN7hi0gu2nRdNeR6UL0rQp+Nuw9v+U9hlel0fwOMLDIyl1eAyrUx/vzCvr0RP5ltIH/zs
 q1YjxWbcgzL+i1TJthH2y2n8Gv1Fl7ka9lDOB3sC/1FBWqPoXZQ7FT96aBmwhCwx8EW+G54y/
 i6IzOohUoX85DreHPkZNPJBdmUWaLKDDitb1moUprXnJJ3eterqFz737jVMX/W7Ax6scra0B9
 NRqVw1lzpaV0QZPekD8aApbTrbCbZH3OidgEs8miMUAlpxXGelZR8BlP1RMjnNVJk6jAIclJh
 9/MgVcWJe8eJNXRyDP7uzvDB0zjAFZWxU3UZMJByJ/IfBoOoG13BGz0+my+QMbjTuQsYpBSfx
 EKSxlX4nMqzhDxVf6tmMqZV4FBIos9shsfebMRCBgp2ki3PYHnxVC0Iynzs17yRj8EejU/FM4
 pdb/5d+bevVtwUXgIe9xPk67DbQBINhxzrpxWYkiaMdlV9xqwVzxp/kKbsLDcW5aH5FRke6EY
 Z8TQwErammEkN/7QOOo/PmrO0HdlyQyWvm81on5M8C67IgiT/qaWYQQjt0m9sJ2okHH6qWW9u
 BYXRVRdNPXpsFTq8i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> this change can fix the warning of tools.

Would you like to point any specific source code analysis tools out
for this issue?
(Can a corresponding attribution become relevant for a clearer
change description?)

Regards,
Markus
