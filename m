Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8366C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724962084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb3kOEqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBXVd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:33:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43496 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:33:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id p7so10047119qkh.10;
        Mon, 24 Feb 2020 13:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aa5Qf9pQ0k9qShhuWKSofog+nYL3D3DoTQ19Ih73G1o=;
        b=pb3kOEqHYHaRf65oifH6+Qx0lDkW7a60pnLPYV2ukWEIdqGsityLSoaKoSB7U/dR+i
         LFFBjFQxloBDdoEVyTlPaLLCijlErj0fLhkpf0YnmP9s1CWO+egbml3KSr3wbmSiTZsZ
         78pKnGDoOn6sY6zLFtgL5liJc37VeOn4ryfrgAzT9APn4JB127yZ9LdY16MgZmv6HcMP
         r4qwFo6xJn8TUfWVdnoRcdI7SPyYwiArshzw3FRl1CN61LqKf77enhTMJuwN3b37tAOq
         Vgk/x4jwl2UFwQVVbIL2L5t/1eYh4pt6mlxSsGLH+RKibI1Rt61ciMocnEpPMpmSuBV+
         mZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aa5Qf9pQ0k9qShhuWKSofog+nYL3D3DoTQ19Ih73G1o=;
        b=kg7jUG8gou6lc+0UzTziKBA/X5lCmgxK6CzXFTb+v2Np/6noNkJdAH1HSO82lwPGMo
         jdDpOLXj0fo6RplwxQbWhxeBpOaxdOU9NB5L7cfJwvcLKA7sQDrJG4Ce/E5jBU9Wu178
         q76d9/xCJzroXBV3RnLjnMT94E8YSExAXfaf6oOr8nUGwwum1b0fBFXl3h57P8mvqoF3
         1B/rODWzs0tkOsq5aaVrvuBvkBw8MMALSo/4IzbS6dluiMhSHCGrZpM7zIkHDYl5/EQd
         J98Z1ZhFlXsp0SvZLTLbNvLlxIKEnPNXu7nbdkO4fiNwIYLopNFLOB/Kkw9sDTj0aKcS
         +Pjg==
X-Gm-Message-State: APjAAAU/yhp2S7+MjgGD/IYbyqgiX19DTVhz1i4o1c8aXFWRsgBLavPy
        I3X1bqy8h1TkN05vcglBIlcgfaD3Jlm+0en9oqo=
X-Google-Smtp-Source: APXvYqycuSdcWXYyvFD0nZUrzQi+k4VGQugWbiYf7nZ1009R04WC3jif75TEuUqxHxIy7QvokAUEWiHMHBo0P4ayTa0=
X-Received: by 2002:a05:620a:7eb:: with SMTP id k11mr49850351qkk.486.1582580004626;
 Mon, 24 Feb 2020 13:33:24 -0800 (PST)
MIME-Version: 1.0
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
In-Reply-To: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
From:   Oleksandr Suvorov <cryosay@gmail.com>
Date:   Mon, 24 Feb 2020 23:33:12 +0200
Message-ID: <CAGgjyvFFiiTp9p6Fjvhjpo6SPj47yLTGoM-RU3Y3pbp+RGfMsA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] arm: dts: imx6: toradex: use SPDX-License-Identifier
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 7:32 PM Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
>
> 1. Replace boiler plate licenses texts with the SPDX license
> identifiers in Toradex iMX6-based SoM device trees.
> 2. As X11 is identical to the MIT License, but with an extra sentence
> that prohibits using the copyright holders' names for advertising or
> promotional purposes without written permission, use MIT license instead
> of X11 ('s/X11/MIT/g').
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

> ---
>
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 40 ++-------------------------
>  arch/arm/boot/dts/imx6q-apalis-eval.dts       | 40 ++-------------------------
>  arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 40 ++-------------------------
>  arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 40 ++-------------------------
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 40 ++-------------------------
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 40 ++-------------------------
>  6 files changed, 12 insertions(+), 228 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> index cd07562..aad47b9 100644
> --- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
> - * Copyright 2014-2016 Toradex AG
> + * Copyright 2014-2020 Toradex AG
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
> index 4665e15..e14e9d4 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
> - * Copyright 2014-2017 Toradex AG
> + * Copyright 2014-2020 Toradex AG
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
> index a3fa04a..bad1deb 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
> - * Copyright 2014-2017 Toradex AG
> + * Copyright 2014-2020 Toradex AG
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> index 5ba49d0..8b700d2 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
> - * Copyright 2014-2017 Toradex AG
> + * Copyright 2014-2020 Toradex AG
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 1b5bc6b..95aa731 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
> - * Copyright 2014-2017 Toradex AG
> + * Copyright 2014-2020 Toradex AG
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index d03dff2..b0ac187 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
> - * Copyright 2014-2016 Toradex AG
> + * Copyright 2014-2020 Toradex AG
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  #include <dt-bindings/gpio/gpio.h>
> --
> 2.7.4
>


-- 
Best regards

Oleksandr Suvorov
cryosay@gmail.com
