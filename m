Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF794C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B562072A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbgCDL5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:57:41 -0500
Received: from eggs.gnu.org ([209.51.188.92]:50885 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387929AbgCDL5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:57:41 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e]:49702)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <lxsameer@gnu.org>)
        id 1j9Seg-0001ih-T4; Wed, 04 Mar 2020 06:57:38 -0500
Received: from [159.253.226.146] (port=45496 helo=[10.4.0.51])
        by fencepost.gnu.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <lxsameer@gnu.org>)
        id 1j9Sed-0005Ci-Dr; Wed, 04 Mar 2020 06:57:36 -0500
Subject: Re: [PATCH] MAINTAINERS: adjust to kobject doc ReST conversion
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200304110821.7243-1-lukas.bulwahn@gmail.com>
From:   Sameer Rahmani <lxsameer@gnu.org>
Message-ID: <959e8f4c-9ff6-4388-9b6f-23f6e548e9e5@gnu.org>
Date:   Wed, 4 Mar 2020 11:57:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304110821.7243-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/03/2020 11:08, Lukas Bulwahn wrote:
> Commit 5fed00dcaca8 ("Documentation: kobject.txt has been moved to
> core-api/kobject.rst") missed to adjust the entry in MAINTAINERS.
>
> Since then, ./scripts/get_maintainer.pl --self-test complains:
>
>    warning: no file matches F: Documentation/kobject.txt
>
> Adjust DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS entry in MAINTAINERS.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Sameer, please ack.
> Jonathan, pick pick this patch for doc-next.
>
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d064049aad1b..998d56e61a41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5213,7 +5213,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>   R:	"Rafael J. Wysocki" <rafael@kernel.org>
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
>   S:	Supported
> -F:	Documentation/kobject.txt
> +F:	Documentation/core-api/kobject.rst
>   F:	drivers/base/
>   F:	fs/debugfs/
>   F:	fs/sysfs/

Hi Lukas,

Thanks for the fix. It looks good to me

