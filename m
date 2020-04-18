Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D245FC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0CD22209
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kQCGXWhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgDRUz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:55:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:51509 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgDRUz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587243275;
        bh=VKy0dQDCaD8oqgDy725ir2gKt+Kxucb5P54PGywTa38=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kQCGXWhVlpl6QVtIxnd0SMXMLVVzhHrIirSGtbnTLIDazLoohm8RpK/5TlhcxSksh
         m7p17hMubGAgexag9MlrcUVhhMQNHW9yLNYYTFK75QoDithmq4DehK5dNBYxvG7Xxt
         LZXP0naIIi4tS7T51GLTcykOt7R2rz/nNZGfzTLY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.147.134]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1jexKE1zDt-00K9bL; Sat, 18
 Apr 2020 22:54:35 +0200
Subject: Re: [PATCHv3 25/50] parisc: Add show_stack_loglvl()
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-26-dima@arista.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 mQINBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABtBxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+iQJRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2ju5Ag0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAGJAjYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLrgzBF3IbakWCSsGAQQB2kcP
 AQEHQNdEF2C6q5MwiI+3akqcRJWo5mN24V3vb3guRJHo8xbFiQKtBBgBCAAgFiEERUSCKCzZ
 ENvvPSX4Pl89BKeiRgMFAl3IbakCGwIAgQkQPl89BKeiRgN2IAQZFggAHRYhBLzpEj4a0p8H
 wEm73vcStRCiOg9fBQJdyG2pAAoJEPcStRCiOg9fto8A/3cti96iIyCLswnSntdzdYl72SjJ
 HnsUYypLPeKEXwCqAQDB69QCjXHPmQ/340v6jONRMH6eLuGOdIBx8D+oBp8+BGLiD/9qu5H/
 eGe0rrmE5lLFRlnm5QqKKi4gKt2WHMEdGi7fXggOTZbuKJA9+DzPxcf9ShuQMJRQDkgzv/VD
 V1fvOdaIMlM1EjMxIS2fyyI+9KZD7WwFYK3VIOsC7PtjOLYHSr7o7vDHNqTle7JYGEPlxuE6
 hjMU7Ew2Ni4SBio8PILVXE+dL/BELp5JzOcMPnOnVsQtNbllIYvXRyX0qkTD6XM2Jbh+xI9P
 xajC+ojJ/cqPYBEALVfgdh6MbA8rx3EOCYj/n8cZ/xfo+wR/zSQ+m9wIhjxI4XfbNz8oGECm
 xeg1uqcyxfHx+N/pdg5Rvw9g+rtlfmTCj8JhNksNr0NcsNXTkaOy++4Wb9lKDAUcRma7TgMk
 Yq21O5RINec5Jo3xeEUfApVwbueBWCtq4bljeXG93iOWMk4cYqsRVsWsDxsplHQfh5xHk2Zf
 GAUYbm/rX36cdDBbaX2+rgvcHDTx9fOXozugEqFQv9oNg3UnXDWyEeiDLTC/0Gei/Jd/YL1p
 XzCscCr+pggvqX7kI33AQsxo1DT19sNYLU5dJ5Qxz1+zdNkB9kK9CcTVFXMYehKueBkk5MaU
 ou0ZH9LCDjtnOKxPuUWstxTXWzsinSpLDIpkP//4fN6asmPo2cSXMXE0iA5WsWAXcK8uZ4jD
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <55e2b275-b232-f009-ab8e-0469506e6e96@gmx.de>
Date:   Sat, 18 Apr 2020 22:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200418201944.482088-26-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g9CB259vry3HDjlljUe/oUrpw0PWkQ4fR6VngeJnzUiqDc8zCYQ
 mEWAeVJhlz4FVDmqkaGkiRBKITR+wI/ln2COKmNt4ZpEGoz1ZceD7B986Ii7xVnAwKSaHZu
 KshAg8W3rTul9xVbf9DTsHqkagFfd4vtM6PfQ1LAsuNjpidY0yjL6d452nYsIdOQmrub3tw
 LN1Vbe5UwYyz/cDKSXBww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IkVwbkTWS/0=:VWKEmA6jhZFGLnMaN+jZMa
 Nx4YX4OGNFPQzbZ0khwtZe2hkLfnFa7n+GNZUUF/imydPnINV4uEwKpU6boB0fhILvqpQY05U
 2ip9iu8B+r3yTUyS4h9zMxjpP7XXsFh7lTtwa3ljHbpW4KaefH/l0NV9GiXwMuPUNJDMKWolX
 b6VYK9lEb2nqQtYRC0REZ4W43Y+Qp7jKp5M/Z4QwXQwsnNmwK+Ett6MUhaM7C+ll7lPJ4OFSd
 OLwCSxeHwYsRYYg5Pe93bRV2U/HTM4ZH+29R2tBJvxOOSUGh41hnYpcXDcMLCXsqoj6Aw2FCm
 DrEcIeDTBG0XcPKKmhWAyEbRDn34VdeoQgkH0QOROhYPXuIU0ZQtQEQcPlZeT6Z22Z+IBdcQC
 slDmVIXqrO2OmAbI9yHJRH/I3Yyske8/lkcg2tjePqcbwSbZD4fIaw+wr89jalvK0rlQ1Ajth
 s22P2/XUw9pTb2H1hUoB1gwVtvTboqT1k9cDPL3N1M3jQv464SqGv4qClAex/4k9kKC0uiXoK
 KKnPHgQa/Rz2GQkh+KMrFhBRnuOy5pxDmiXBTXqNOH7kRyvB6dm0eSYYc36TytY6INrOtBG5P
 5ItwwD+6t91yuXjG6VVZJuZM/JGVtT5G0G+t0hN3Xqmx4b9uk0bjYxKRk0qyHu08Kk7G2pY2H
 fyZIDpbFXQMERia3SSdp5ar2IZUo83EJ1Ak9kZXCnGauVHCIvMGwljOaLvYBlGYPQzHBjGVob
 nPo0RN9Kz6yHP+CG2zpw1FzSi3I3LEFv6XGJ11ChQA8ApbUmzQlMsxrL8jvmCbL0oe/cnuTEH
 nym6H7ACpHdfXOkZo24lJyA+5+7xhzzaOG7XH1dJ0DMEuBcb0Ox7BIbLiQx0N2DZZf01JK6S1
 KyIfkfhWPUtkOTtX+pLysPfMZmDx6rihoECOctOaLv4y9RKXuoJyOIzIig0GO5jqofVFTNTrM
 q7Ha3MGyrIfIqvnINrL93mpdo8Z02UMskq2fyG92pcSIRhKsCA4LgZ1LkBiqoCoG+dPZn+hrM
 0T/o5X3Dgr9uNxuxSSdJKlmIn6u7qNa7lOh74Woj9R0cjxfnNonhDFKhAOKzRKl0KboUe5mYp
 f/DVuSgWscbsGPn5Y5w2aIhJZNuodRbYJaR1XTndB2i+a+PPj61lbJLLHWmCjlcD8G2wD8Q4u
 NhT9ZxWfzbhnNo/fcTVVzlFyAteMQqd36WHvPtROoOwIInOV/FlvVKzjvLDoo5Q7tsl6k7jfA
 FD2jkA6wbn0M7/92O
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.20 22:19, Dmitry Safonov wrote:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
>
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
>
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
>
> Introduce show_stack_loglvl(), that eventually will substitute
> show_stack().
>
> Cc: Helge Deller <deller@gmx.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: linux-parisc@vger.kernel.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/=
T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/parisc/kernel/traps.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge


>
> diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
> index 82fc01189488..c2411de3730f 100644
> --- a/arch/parisc/kernel/traps.c
> +++ b/arch/parisc/kernel/traps.c
> @@ -49,7 +49,7 @@
>  #include "../math-emu/math-emu.h"	/* for handle_fpe() */
>
>  static void parisc_show_stack(struct task_struct *task,
> -	struct pt_regs *regs);
> +	struct pt_regs *regs, const char *loglvl);
>
>  static int printbinary(char *buf, unsigned long x, int nbits)
>  {
> @@ -155,7 +155,7 @@ void show_regs(struct pt_regs *regs)
>  		printk("%s IAOQ[1]: %pS\n", level, (void *) regs->iaoq[1]);
>  		printk("%s RP(r2): %pS\n", level, (void *) regs->gr[2]);
>
> -		parisc_show_stack(current, regs);
> +		parisc_show_stack(current, regs, KERN_DEFAULT);
>  	}
>  }
>
> @@ -170,37 +170,43 @@ static DEFINE_RATELIMIT_STATE(_hppa_rs,
>  }
>
>
> -static void do_show_stack(struct unwind_frame_info *info)
> +static void do_show_stack(struct unwind_frame_info *info, const char *l=
oglvl)
>  {
>  	int i =3D 1;
>
> -	printk(KERN_CRIT "Backtrace:\n");
> +	printk("%sBacktrace:\n", loglvl);
>  	while (i <=3D MAX_UNWIND_ENTRIES) {
>  		if (unwind_once(info) < 0 || info->ip =3D=3D 0)
>  			break;
>
>  		if (__kernel_text_address(info->ip)) {
> -			printk(KERN_CRIT " [<" RFMT ">] %pS\n",
> -				info->ip, (void *) info->ip);
> +			printk("%s [<" RFMT ">] %pS\n",
> +				loglvl, info->ip, (void *) info->ip);
>  			i++;
>  		}
>  	}
> -	printk(KERN_CRIT "\n");
> +	printk("%s\n", loglvl);
>  }
>
>  static void parisc_show_stack(struct task_struct *task,
> -	struct pt_regs *regs)
> +	struct pt_regs *regs, const char *loglvl)
>  {
>  	struct unwind_frame_info info;
>
>  	unwind_frame_init_task(&info, task, regs);
>
> -	do_show_stack(&info);
> +	do_show_stack(&info, loglvl);
> +}
> +
> +void show_stack_loglvl(struct task_struct *t, unsigned long *sp,
> +		       const char *loglvl)
> +{
> +	parisc_show_stack(t, NULL, loglvl);
>  }
>
>  void show_stack(struct task_struct *t, unsigned long *sp)
>  {
> -	parisc_show_stack(t, NULL);
> +	show_stack_loglvl(t, sp, KERN_CRIT)
>  }
>
>  int is_valid_bugaddr(unsigned long iaoq)
> @@ -446,7 +452,7 @@ void parisc_terminate(char *msg, struct pt_regs *reg=
s, int code, unsigned long o
>  		/* show_stack(NULL, (unsigned long *)regs->gr[30]); */
>  		struct unwind_frame_info info;
>  		unwind_frame_init(&info, current, regs);
> -		do_show_stack(&info);
> +		do_show_stack(&info, KERN_CRIT);
>  	}
>
>  	printk("\n");
>

