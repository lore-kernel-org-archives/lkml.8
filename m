Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B384C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453252072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Hrn/NTdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCER5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:57:24 -0500
Received: from mout.web.de ([212.227.17.12]:38269 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgCER5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583431007;
        bh=1MBvqI6rf+lTsOP6IFeGlnNUDsq+DzxC+FROZLnRX2A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hrn/NTdGaYL2lXo/ywhkktcL6+pFg8YV/EiKX/M4ft4Cyk7mrb85usE899JqGspN3
         m5/92FF5kXC02jh8pN/IpidfEAJWSCCdBEdZDWGEGUGhLRWHarmDa+FxPUO2dcLbEe
         1rvJ3AtcM/EOW0UQ+eJlCkguztr0mg+4eKdUIbWE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MaJvw-1iuZi2415k-00Jplu; Thu, 05
 Mar 2020 18:56:47 +0100
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
 <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
Date:   Thu, 5 Mar 2020 18:56:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:O+AnGFN4JxVLXM9yTK+I4l0AxTwFi57bTZg/Y4FLwJ+tthKAqws
 2dutL1gN9Wz2HM4iw1dNPgC6mpGmOdRIaJm/v1b4XQBg2C9HkfSoOp5pey/Gu5DqvVBkdoQ
 cbfPzFX6qDoDoaT8of21bHFh256/QfoYnePXUMXI0F9JmHrOzlfxO3Qe0mEj6KoQzp/C3Q0
 DQg1DNfZHohqqBx1Vhbnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U5uFCh4pN2o=:Xzr61yss8E1gx7jaLNNpWT
 gZ+1HUHnZt+TJoh8/7e0hXVV8zTxabIfEVX/x+CJvJYjl/y+LD1RbchKGc2yI/IDi9lFF3amq
 hNh2CYVC3uHUd8hXQdldEwV8pjReMfVjkFxYZ9nrU9dSrjqfcryPEAYzabx9IQEg06Q+S3Jpb
 TzHM+kySl0JgMuVEWA0m1XKWbqIYTAE/MEDw8q2GATuQ4lnZw5Rc1h77gC74TdRMDva/RC/t+
 EPULG5rTrSXtCZHj1NlaurlJWusZCOrUaLMF/GLSWhust+ft7dh+Uv3DdRoweV0NmJP0D0xwY
 mKCbuP9VnBxaDcg2V3rX/XWB8VpxlfYW+BiY68C0smL1eDWUWDgV46Tr4k6wTr0/6veqKU6/b
 YQAIGwCx2QZro+vD0xln3zY1vrGLpfRx5s2Ev+cRBZN5RpJyKAM8EWPb5zkKqrZrvdodoAw1y
 P/U+XD0CeHlXWBYN8bvsMFpxC60qfLvfXsr5SiBh1QM0ufx3D1vEzTVqhkv+OnC/OGvHT54kb
 z2KA6qh76XdlIh+c6Az8wjYLwZv6RvrQcwsfzgHhNAQ/Xcjs/itbLWXOQCZm9RAPdRvN3sgyQ
 QEfyOews+G2HAW3e8EaYfBDB0PgxAo3mfKGl4xNxIDTjS8fStY7aCTWSXT2kgjmw94HYG9dE3
 x0M5C9Y+MTuBEXYgNrvbyOCNptVBZ40EjrGv8fFm7OKHAG4Nli6g9xGenLBOVyBgfiFW6JMcV
 QNm4pmG1Tz7TtJ8WszJ2GcVIlnx7haOtWG0QSthPfDCiRB55O/BUe6++n7HR3rPmnxDxXIICZ
 JcKwusDjR0L9qk09BXiG4CxHSLf5oc7rt4SxuVIR/lLx3wemOVb3zO8ECT0k9BovS1heD5TfY
 /j6Ex00CLN5edEQ0o3HgSCl+kG2LrqBHtldtdR+8V8zs2IPeJ1uztfz/b4qmlp7NCrjhT7hLo
 1H1+ZfbLw62KDimt7sQFYkVd255J1F4kUqTckVhQ1NwFJgpxl8RSGf53cNO9eelXAgDPMvplO
 5gVPYwFSZflR02/AIlacjC953qG4POTdERBvHpZYmKtMVC00o6/UW6s85UW8eXTYGP6IH2Js+
 zgBJVI8DgyRy1bwiYs4JWgHziHDc120ivpUsD8c5Xsnialegzuc5SyQOToXf2uknb07HvDwlW
 R961UgRmrTuB6m+GqhqMZAJxYbdoADJ3E/LVMNQbYU6zPrb1R6qZleTpO7KaNqvLH/+uqVdlx
 32jXyKBDK3Elfz3sB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you would (could) be more concrete (or discrete) in your suggestions,
> I would be glad to comment on them.

Does this view indicate any communication difficulties?

Which of the possibly unanswered issues do you find not concrete enough so far?

Regards,
Markus
