Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E199C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535E320759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgG0KnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:43:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36774 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgG0KnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:43:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 68A53295BE9
Subject: Re: [PATCH] platform/chrome: cros_ec: Fix host command for regulator
 control.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yicheng Li <yichengli@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200724080358.619245-1-pihsun@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <223053a7-bcee-f8d2-1b9d-68503d04126f@collabora.com>
Date:   Mon, 27 Jul 2020 12:42:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724080358.619245-1-pihsun@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pi-Hsun, Mark

Thank you for your patch.

On 24/7/20 10:03, Pi-Hsun Shih wrote:
> Since the host command number 0x012B conflicts with other EC host
> command, add one to all regulator control related host command.
> 
> Also fix a wrong alignment on struct and sync the comment with the one
> in ChromeOS EC codebase.
> 
> Fixes: dff08caf35ec ("platform/chrome: cros_ec: Add command for regulator control.")
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

This needs to go through Mark Brown's regulator tree as depends on
dff08caf35ec, if not, I can pick as a fix when the next merge window is closed.

> ---
> The original numbers were chosen before the 0x012B is used in ChromeOS
> EC codebase. Since the original kernel patch got accepted before the
> corresponding commit in ChromeOS EC codebase got merged, the host
> command number was used by other commit first.
> 

Ups, next time we need to make sure the EC code lands before.


> Since now the commit in ChromeOS EC codebase
> (https://crrev.com/c/2247431) with updated host command numbers got
> merged, need this patch to sync up the host command numbers with
> ChromeOS EC codebase. Sorry for the confusion.
> ---
>  include/linux/platform_data/cros_ec_commands.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index a417b51b5764..91e77f53414d 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -5438,7 +5438,7 @@ struct ec_response_rollback_info {
>   *
>   * Returns the regulator name and supported voltage list in mV.
>   */
> -#define EC_CMD_REGULATOR_GET_INFO 0x012B
> +#define EC_CMD_REGULATOR_GET_INFO 0x012C
>  
>  /* Maximum length of regulator name */
>  #define EC_REGULATOR_NAME_MAX_LEN 16
> @@ -5454,12 +5454,12 @@ struct ec_response_regulator_get_info {
>  	char name[EC_REGULATOR_NAME_MAX_LEN];
>  	uint16_t num_voltages;
>  	uint16_t voltages_mv[EC_REGULATOR_VOLTAGE_MAX_COUNT];
> -} __ec_align1;
> +} __ec_align2;
>  
>  /*
>   * Configure the regulator as enabled / disabled.
>   */
> -#define EC_CMD_REGULATOR_ENABLE 0x012C
> +#define EC_CMD_REGULATOR_ENABLE 0x012D
>  
>  struct ec_params_regulator_enable {
>  	uint32_t index;
> @@ -5471,7 +5471,7 @@ struct ec_params_regulator_enable {
>   *
>   * Returns 1 if the regulator is enabled, 0 if not.
>   */
> -#define EC_CMD_REGULATOR_IS_ENABLED 0x012D
> +#define EC_CMD_REGULATOR_IS_ENABLED 0x012E
>  
>  struct ec_params_regulator_is_enabled {
>  	uint32_t index;
> @@ -5489,7 +5489,7 @@ struct ec_response_regulator_is_enabled {
>   * Also note that this might be called before the regulator is enabled, and the
>   * setting should be in effect after the regulator is enabled.
>   */
> -#define EC_CMD_REGULATOR_SET_VOLTAGE 0x012E
> +#define EC_CMD_REGULATOR_SET_VOLTAGE 0x012F
>  
>  struct ec_params_regulator_set_voltage {
>  	uint32_t index;
> @@ -5500,9 +5500,10 @@ struct ec_params_regulator_set_voltage {
>  /*
>   * Get the currently configured voltage for the voltage regulator.
>   *
> - * Note that this might be called before the regulator is enabled.
> + * Note that this might be called before the regulator is enabled, and this
> + * should return the configured output voltage if the regulator is enabled.
>   */
> -#define EC_CMD_REGULATOR_GET_VOLTAGE 0x012F
> +#define EC_CMD_REGULATOR_GET_VOLTAGE 0x0130
>  
>  struct ec_params_regulator_get_voltage {
>  	uint32_t index;
> 
> base-commit: 8d9f8d57e023893bfa708d83e3a787e77766a378
> 
